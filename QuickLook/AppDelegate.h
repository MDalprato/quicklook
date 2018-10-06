//
//  AppDelegate.h
//  QuickLook
//
//  Created by Marco Dalprato on 26/06/15.
//  Copyright (c) 2015 Marco Dalprato. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebView.h> 

@interface AppDelegate : NSObject <NSApplicationDelegate>

// Status Menu

@property (strong, nonatomic) NSStatusItem *statusBar;
@property (weak) IBOutlet NSMenu *statusMenu;
@property (nonatomic, retain) NSMutableArray *user_cameras_list_array;
@property (weak) IBOutlet NSMenu *camera_sub_menu;

// Camera add form

@property (weak) IBOutlet NSTextField *camera_alias;
@property (weak) IBOutlet NSTextField *camera_ip;
@property (weak) IBOutlet NSTextField *camera_port;
@property (weak) IBOutlet NSTextField *camera_username;
@property (weak) IBOutlet NSSecureTextField *camera_password;

// ***

@property (weak) IBOutlet NSComboBox *camera_brand_combobox;
@property (weak) IBOutlet NSComboBox *camera_model_combobox;
@property (weak) IBOutlet NSImageView *preview_image;

// ******


- (IBAction)add_camera:(id)sender;

- (IBAction)reset_all:(id)sender;
- (IBAction)show_preview:(id)sender;


@property (weak) IBOutlet NSSlider *fps_slider;
@property (weak) IBOutlet NSTextField *fps_label;
@property (weak) IBOutlet NSSlider *menu_slider;
@property (weak) IBOutlet NSTextField *menu_label;

- (IBAction)fps_slider_action:(id)sender;
- (IBAction)menu_slider_action:(id)sender;
- (IBAction)choose_brand_action:(id)sender;
- (IBAction)internal_db_btn:(id)sender;
- (IBAction)external_db_btn:(id)sender;

@property (weak) IBOutlet NSTextField *thumbnails_size_w;
@property (weak) IBOutlet NSTextField *thumbnails_size_h;
@property (weak) IBOutlet NSMenuItem *cameras_menu_controller;

@property (weak) IBOutlet NSView *cameras_dynamic_scrollview;

@property (weak) IBOutlet NSScrollView *camera_scrollview_container;

- (IBAction)settings_menu_btn:(id)sender;

- (IBAction)thumbnail_size_selector:(id)sender;
@property (weak) IBOutlet NSSegmentedControl *thumbnail_size_value;

- (IBAction)reflashmenu_selector:(id)sender;
@property (weak) IBOutlet NSSegmentedControl *reflashmenu_selector_value;

- (IBAction)reflashinterval_selector:(id)sender;
@property (weak) IBOutlet NSSegmentedControl *reflashinterval_selector_value;

@property (strong) NSWindow* myWindow;
@property(strong)NSMutableArray *myWindowArray;
@property(strong)NSMutableArray *myWindowArray_name;
@property(strong)NSMutableArray *myWindowArray_url_image;
@property(strong)NSMutableArray *myWindowArray_windownumber;
@property(strong)NSMutableArray *myWindowArray_tag;

- (IBAction)show_layout:(id)sender;

@property (weak) IBOutlet NSPanel *camera_panel;
- (IBAction)reload_scroll_view_button:(id)sender;
- (IBAction)save_snapshosts:(id)sender;
@property (weak) IBOutlet NSPathControl *folder_control;
- (IBAction)folder_action:(id)sender;
@property (weak) IBOutlet NSTextField *folder_label;

@end

