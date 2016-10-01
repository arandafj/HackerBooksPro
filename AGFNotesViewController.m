//
//  AGFNotesViewController.m
//  HackerBooksPro
//

#import "AGFNotesViewController.h"
#import "AGFNoteViewController.h"
#import "AGFCollectionViewCell.h"
#import "AGFAnnotation.h"
#import "AGFImage.h"
#import "AGFBook.h"

@interface AGFNotesViewController ()

@end

@implementation AGFNotesViewController


#pragma mark -  View Lifecicle
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Registrar nib de los items de la collection view
    UINib *nib = [UINib nibWithNibName:@"AGFCollectionViewCell" bundle:nil];
    
    // Registar nib
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:[AGFCollectionViewCell cellId]];
    
    self.title = @"Annotations";
    
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                         target:self
                                                                         action:@selector(addNote:)];
    self.navigationItem.rightBarButtonItem = add;
    
}

#pragma mark - Data Source
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // Obtener objeto
    AGFAnnotation *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Obtenemos celda
    AGFCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[AGFCollectionViewCell cellId]
                                                                      forIndexPath:indexPath];
    
    // Configurar la celda
    cell.title.text = note.title;
    cell.photoView.image = note.image.img;
    
    // Formatear fecha
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateFormatterMediumStyle;
    cell.modificationDate.text = [fmt stringFromDate:note.modificationDate];
    
    // Devolver celda
    return cell;
}

#pragma mark - Utils
-(void) addNote:(id) sender{
    
    AGFNoteViewController *newNoteVC = [[AGFNoteViewController alloc] initForNewAnnotationInBook:self.book];
    [self.navigationController pushViewController:newNoteVC
                                         animated:YES];
}

#pragma mark -  Delegate
-(void) collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    // Obtener objeto
    AGFAnnotation *note = [self.fetchedResultsController objectAtIndexPath:indexPath];

    // Crear controlador
    AGFNoteViewController *noteVC = [[AGFNoteViewController alloc] initWithModel:note];

    // Hacer un push
    [self.navigationController pushViewController:noteVC
                                         animated:YES];

}

@end
