//
//  AGFMasterViewController.m
//  HackerBooksPro
//

#import "AGFMasterViewController.h"
#import "AGFDetailViewController.h"
#import "AGFBookCellView.h"
#import "AGFBook.h"
#import "AGFAuthor.h"
#import "AGFPhoto.h"
#import "AGFTag.h"
#import "Settings.h"

@interface AGFMasterViewController () < UISearchResultsUpdating, UISearchBarDelegate>

@property (nonatomic) BOOL isSearching;
@property (strong, nonatomic) UISearchController *sc;
@end

@implementation AGFMasterViewController

#pragma mark - View LifeCycle
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Se le da un título
    self.title = @"Library";
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateChanges)
                                                 name:[AGFDetailViewController favoriteSwitchChangeKey]
                                               object:nil];
    
    // Se registra la celda
    UINib *nib = [UINib nibWithNibName:@"AGFBookCellView" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:[AGFBookCellView cellId]];
    
    // Creación y configuración del searchController
    self.sc = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.sc.searchResultsUpdater = self;
    self.sc.dimsBackgroundDuringPresentation = false;
    self.definesPresentationContext = true;
    self.tableView.tableHeaderView = self.sc.searchBar;
    self.sc.searchBar.scopeButtonTitles = @[@"Title", @"Tag", @"Author"];
    self.sc.searchBar.delegate = self;
    [self.sc.searchBar sizeToFit];

    
}

-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

#pragma mark - DataSource
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AGFBook *book = [self bookAtIndexPath:indexPath];

    // Crear celda
    AGFBookCellView *cell = [tableView dequeueReusableCellWithIdentifier:[AGFBookCellView cellId]];
    
    // Configurar celda en función del libro seleccionado
    cell.title.text = book.title;
    cell.authors.text = [book.obtainAuthors componentsJoinedByString:@","];
    
    if (book.photo.photo != nil) {
        cell.image.image = book.photo.photo;
    } else {
        UIImage *imageBook = [UIImage imageNamed:@"book.png"];
        cell.image.image = imageBook;
    }
    
    // Devolver la celda
    return cell;
    
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    // En caso de estar en una búsqueda, se devuelve o los libros de un tag o los objetos
    // de fetchedResultsController
    if (self.isSearching == YES) {
        return self.fetchedResultsController.fetchedObjects.count;
    } else {
        return [[[self.fetchedResultsController.fetchedObjects objectAtIndex:section] books] count];
    }
    
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    // Se elimina la barra de índice de búsqueda
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // La cabecera de la sección cambia en función de si se trata de un resultado de una búsqueda
    // o de los nombres de los tags
    if (self.isSearching == YES) {
        return @"Resultados Búsqueda";
    } else {
        NSString *sectionName = [[[self.fetchedResultsController sections] objectAtIndex:section] name];
        return [sectionName substringFromIndex:1];
    }

}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    // En caso de estar en una búsqueda hay una única sección, en caso contrario hay tantas secciones como tags encuentre
    if (self.isSearching == YES) {
        return 1;
    } else {
        return [super numberOfSectionsInTableView:tableView];
    }
}

#pragma mark - Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    // Rellenar con los datos del libro seleccionado
    AGFBook *book = [self bookAtIndexPath:indexPath];
    
    // Se guarda su identificador en local
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:book.archiveURIRepresentation forKey:BOOK_SELECTED_KEY];
    [defaults synchronize];
    
    // Se crea controlador de detalle y se muestra
    AGFDetailViewController *detailVC = [[AGFDetailViewController alloc] initWithBook:book context:self.fetchedResultsController.managedObjectContext];
    [detailVC downloadCover];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:detailVC];
    
    [self.splitViewController showDetailViewController:nc sender:self];
}

#pragma mark - Utils
- (AGFBook *) bookAtIndexPath:(NSIndexPath *) indexPath{
    
    if (self.isSearching == YES) {
        if (self.fetchedResultsController.fetchedObjects.count == 0 ) {
            return 0;
        } else {
            return [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
        }
    } else {
        AGFTag *tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.section];
        AGFBook *book = [[tag.books allObjects] objectAtIndex:indexPath.row];
        return book;
    }
    
}

-(void)updateChanges{
    
    [self.tableView reloadData];
    
}

#pragma mark - UISearchResultsUpdating
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSFetchedResultsController *results = nil;
    NSPredicate *pred = nil;
    
    if (searchController.searchBar.text.length != 0) {
        
        NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AGFBook entityName]];
        
        // Búsqueda por título
        if (searchController.searchBar.selectedScopeButtonIndex == 0) {
            pred = [NSPredicate predicateWithFormat:@"title BEGINSWITH[c] %@", searchController.searchBar.text];
        }
        
        // Búsqueda por Tag
        if (searchController.searchBar.selectedScopeButtonIndex == 1) {
            pred = [NSPredicate predicateWithFormat:@"tags.name CONTAINS[c] %@", searchController.searchBar.text];
        }
        // Búsqueda por Autor
        if (searchController.searchBar.selectedScopeButtonIndex == 2) {
            pred = [NSPredicate predicateWithFormat:@"authors.name CONTAINS[c] %@", searchController.searchBar.text];
        }
        
        req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:AGFBookAttributes.title
                                                              ascending:YES selector:@selector(caseInsensitiveCompare:)]];
        req.predicate = pred;
        
        results = [[NSFetchedResultsController alloc] initWithFetchRequest:req
                                                      managedObjectContext:self.fetchedResultsController.managedObjectContext
                                                        sectionNameKeyPath:nil
                                                                 cacheName:nil];
        self.isSearching = YES;
        
        
    } else {
        NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AGFTag entityName]];
        req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:AGFTagAttributes.name
                                                              ascending:YES selector:@selector(caseInsensitiveCompare:)]];
        
        results = [[NSFetchedResultsController alloc] initWithFetchRequest:req
                                                      managedObjectContext:self.fetchedResultsController.managedObjectContext
                                                        sectionNameKeyPath:AGFTagAttributes.name
                                                                 cacheName:nil];
        self.isSearching = NO;
        
    }
    
    self.fetchedResultsController = results;
    
    NSError *err = nil;
    [self.fetchedResultsController performFetch:&err];
    [self updateChanges];

}
@end
