//
//  AppDelegate.m
//  QuickLook
//
//  Created by Marco Dalprato on 26/06/15.
//  Copyright (c) 2015 Marco Dalprato. All rights reserved.
//

#import "AppDelegate.h"

// defining some stuff for the colors of the windows
#define RGB(r, g, b) [NSColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:1.0]
#define RGBA(r, g, b, a) [NSColor colorWithRed:(float)r / 255.0 green:(float)g / 255.0 blue:(float)b / 255.0 alpha:a]

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *add_camera_window;
@property (weak) IBOutlet NSWindow *home_window;

@end

// **** VARIABLES DECLARATIONS  ****

NSMutableArray *brands_array;
NSMutableArray *models_array;
NSMutableArray *models_connection_string_array;
NSMutableArray * user_cameras_list_array;

// *** USER CAMERAS LIST ***

NSMutableArray * camera_alias_array;
NSMutableArray * camera_url_array;
NSMutableArray * camera_port_array;
NSMutableArray * camera_username_array;
NSMutableArray * camera_password_array;
NSMutableArray * camera_brand_array;
NSMutableArray * camera_model_array;


double timerInterval = 1.0f;
double menuInterval = 60.0f;

NSInteger temp_camera_id = 0;
NSTimer *timer;
NSTimer * timer_menu;

NSString * stringAddress;

NSString * fps_value_saved;
NSString * fps_value_menu_saved;
NSString * folder_saved;
NSString * online_camera_db_url = @"http://www.marcodalprato.com/wp-content/uploads/quicklook/online_camera_db.txt";
NSString * url_update = @"http://www.marcodalprato.com/wp-content/uploads/quicklook/version.txt";
NSString * url_update_download = @"http://www.marcodalprato.com/wp-content/uploads/quicklook/quicklooknv.zip";
NSString * app_version; // Version of the app (like 1.0)
NSString * webpage_response = @"Still nothing";
NSString * thumbnails_size_h_saved;
NSString * thumbnails_size_w_saved;

// *********************************

@implementation AppDelegate

@synthesize statusBar;
@synthesize statusMenu;
@synthesize camera_sub_menu;

// Strings for camera add function

@synthesize camera_alias;
@synthesize camera_ip;
@synthesize camera_port;
@synthesize camera_username;
@synthesize camera_password;
@synthesize camera_brand_combobox;
@synthesize camera_model_combobox;
@synthesize preview_image;
@synthesize add_camera_window;
@synthesize home_window;
@synthesize fps_label;
@synthesize fps_slider;
@synthesize menu_label;
@synthesize menu_slider;
@synthesize thumbnails_size_h;
@synthesize thumbnails_size_w;
@synthesize cameras_menu_controller;
@synthesize cameras_dynamic_scrollview;
@synthesize camera_scrollview_container;
@synthesize thumbnail_size_value;
@synthesize reflashmenu_selector_value;
@synthesize reflashinterval_selector_value;
@synthesize myWindow;
@synthesize myWindowArray;
@synthesize myWindowArray_url_image;
@synthesize myWindowArray_name;
@synthesize myWindowArray_windownumber;
@synthesize myWindowArray_tag;
@synthesize camera_panel;
@synthesize folder_control;
@synthesize folder_label;

// Here comes the magic ....

- (void) awakeFromNib {
	
	// ********* STATUS BAR CODE *********
	// ***********************************
	
	self.statusBar = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
	// self.statusBar.title = @"QL";
	// you can also set an image
	
	NSImage *newImage;

		newImage = [NSImage imageNamed:@"app_logo.png"];
		[newImage setSize: NSMakeSize(18,18)];
	

	self.statusBar.image =newImage;
	
	
	self.statusBar.menu = self.statusMenu;
	self.statusBar.highlightMode = YES;
	
}

  

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	
	

	
	// adding color/alpha to all the windows of the app

	[self.home_window setBackgroundColor: RGBA(180, 181, 185, 0.97)];
	[self.home_window setOpaque: NO];
	
	[self.add_camera_window setBackgroundColor:  RGBA(180, 181, 185, 0.97)];
	[self.add_camera_window setOpaque: NO];
	
	[self.camera_panel setBackgroundColor:  RGBA(180, 181, 185, 0.97)];
	[self.camera_panel setOpaque: NO];
	
	
	// RESET ALL
	
	//	NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
	//[[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
	
	
	// Inizialize the mutable arrays for the windows
	
	self.myWindowArray=[NSMutableArray new];
	self.myWindowArray_name=[NSMutableArray new];
	self.myWindowArray_url_image=[NSMutableArray new];
	self.myWindowArray_windownumber=[NSMutableArray new];
	self.myWindowArray_tag = [NSMutableArray new];

	// Initialization of the arrays
	
	camera_alias_array = [[NSMutableArray alloc] init];
	camera_url_array = [[NSMutableArray alloc] init];
	camera_port_array = [[NSMutableArray alloc] init];
	camera_username_array = [[NSMutableArray alloc] init];
	camera_password_array = [[NSMutableArray alloc] init];
	camera_brand_array = [[NSMutableArray alloc] init];
	camera_model_array = [[NSMutableArray alloc] init];
	
	brands_array							= [[NSMutableArray alloc] init];
	models_array							= [[NSMutableArray alloc] init];
	models_connection_string_array			= [[NSMutableArray alloc] init];
	
	
	// Loading data
	
	[self function_load_model_list];
	// Loading all the settings
	
	camera_alias_array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"camera_alias_array"]];
	camera_url_array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"camera_url_array"]];
	camera_port_array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"camera_port_array"]];
	camera_username_array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"camera_username_array"]];
	camera_password_array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"camera_password_array"]];
	camera_brand_array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"camera_brand_array"]];
	camera_model_array = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"camera_model_array"]];
	
	[self function_popolate_interface];

	
	
	
	timer_menu = [NSTimer scheduledTimerWithTimeInterval: menuInterval
											 target: self
										   selector:@selector(menu_tick:)
										   userInfo: nil
											repeats: YES];

	// select the first element
	
	[self performSelectorInBackground:@selector(check_new_versions_fuction) withObject:nil];
	
	
	folder_saved =[[NSUserDefaults standardUserDefaults] objectForKey:@"folder_saved"];
	
	folder_label.stringValue = folder_saved;
	
	
	NSLog(@"path == %@",folder_saved);
	
}

-(void)check_new_versions_fuction{
	
	// // // NSLog(@"Check for new versions");
	
	 
	 NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url_update]];
	 NSError *err;
	 NSURLResponse *response;
	 NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
	 webpage_response = [[NSString alloc]initWithData:responseData encoding:NSASCIIStringEncoding];
	 
	 app_version =[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
		
	 float current_app_version = [app_version floatValue];
	 float last_app_version = [webpage_response floatValue];
	 // // NSLog(@"webpage_response = %@", webpage_response);
	 
	 
	  // NSLog(@"local version = %f", current_app_version);
	  // NSLog(@"Remote version = %f", last_app_version);
	 
	 
	 if(last_app_version > current_app_version){
	 
		
		 // NSLog(@"New Version available");
		 
		 
		 NSString * private_key_msg = [NSString stringWithFormat:@"New version available, do you want to download it ?"];
		 NSAlert* msgBox = [[NSAlert alloc] init];
		 [msgBox setMessageText:private_key_msg];
		 [msgBox addButtonWithTitle: @"OK"];
		 [msgBox runModal];
		 
		
		 NSURL * url = [NSURL URLWithString:url_update_download];
		 [[NSWorkspace sharedWorkspace] openURL:url];
	 }

	
	
} // function for check new versions

- (void)menu_tick:(NSTimer *)theTimer {

	// calling the update menu bar in a new thread
	
		[NSThread detachNewThreadSelector:@selector(update_menu_bar) toTarget:self withObject:nil];
	
}

-(void)function_popolate_scrollview{
	
	

	[self function_clean_scrollview];


	int i;
	int position = 1;
	int distance_between_thumnails = 10;
	int thumnail_width = 198;
	int thumbnail_height = 130;
	float total_scrollview_height = [camera_alias_array count] * (thumbnail_height + distance_between_thumnails);
	int scroll_view_size = camera_scrollview_container.frame.size.height;
	
	
	
	if(total_scrollview_height < scroll_view_size){
		total_scrollview_height = scroll_view_size;
	}
	
	[camera_scrollview_container.documentView setFrame: NSMakeRect(0,0,thumnail_width,total_scrollview_height) ];
	
	// NSLog(@"Creo scroll view alta =%f ",total_scrollview_height);
	
	
	// NSLog(@"[camera_alias_array count] = %lu",(unsigned long)[camera_alias_array count]);
	
	
	for (i = 0; i < [camera_alias_array count]; i++) {
		
	
	
		float magic = (total_scrollview_height - (thumbnail_height*position)) - (distance_between_thumnails * position);
		
		
		NSImageView *subview = [[NSImageView alloc] initWithFrame:CGRectMake(0.0f,magic ,thumnail_width, thumbnail_height)];
		NSString *  camera_url = [self function_get_camera_url_from_id:i];
		
		
		NSImage *newImage;
		NSURL *imageURL = [NSURL URLWithString:camera_url];
		
		NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
		if (imageData != nil) {
			newImage = [[NSImage alloc] initWithData:imageData];
			// thumb size
			[newImage setSize: NSMakeSize(thumnail_width,thumbnail_height)];
		}else{
			newImage = [NSImage imageNamed:@"webcam-offline.jpg"];
			// thumb size
			[newImage setSize: NSMakeSize(thumnail_width,thumbnail_height)];

		}

		[subview setImage:newImage];
		[subview setAutoresizingMask:NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin];
		[subview setTag:i];
		
		// NSLog(@"sub id = %i",i);
		[cameras_dynamic_scrollview addSubview:subview];
	
		
		NSTextField *textField;
		textField = [[NSTextField alloc] initWithFrame:NSMakeRect(15,magic + 100,130, 20)];
		[textField setStringValue:[NSString stringWithFormat:@"%@", camera_alias_array[i]]];
		[textField setFont:[NSFont fontWithName:@"HelveticaNeue-Light" size:10]];
		[textField setTextColor:[NSColor whiteColor]];
		[textField setBezeled:NO];
		[textField setDrawsBackground:YES];
		[textField setBackgroundColor:RGB(0, 0, 0)];
		[textField setEditable:NO];
		[textField setSelectable:NO];
		[textField setTag:i];

		[cameras_dynamic_scrollview addSubview:textField];
		
		
		NSButton * delete_button;
		delete_button =  [[NSButton alloc] initWithFrame:NSMakeRect(15,magic+10,80, 20)];
		
		[delete_button setTitle:@"Delete"];
		[delete_button setButtonType: NSMomentaryPushInButton];
		[delete_button setBezelStyle: NSRoundedBezelStyle];
		[delete_button setBordered: YES];
		[delete_button setTarget: self];
		[delete_button setTag:i];
		[delete_button setAction: @selector(sc_delete_button_click:)];
		
		[cameras_dynamic_scrollview addSubview:delete_button];
		
		
		NSButton * live_button;
		live_button =  [[NSButton alloc] initWithFrame:NSMakeRect(100,magic+10,80, 20)];
		
		[live_button setTitle:@"Live"];
		[live_button setButtonType: NSMomentaryPushInButton];
		[live_button setBezelStyle: NSRoundedBezelStyle];
		[live_button setBordered: YES];
		[live_button setTarget: self];
		[live_button setTag:i];
		[live_button setAction: @selector(sc_live_button_click:)];
		
		[cameras_dynamic_scrollview addSubview:live_button];

		
		position++;
		
	}
	



}

- (IBAction)sc_delete_button_click:(id)sender{
	
	NSButton *clicked = (NSButton *) sender;
	
	int myInt = (int)clicked.tag;

	
	[self function_delete_camera:myInt];

	[self function_popolate_interface];
	
	[self function_save];
	
	// NSLog(@"Delete a camera");
	// manage closing
}

- (IBAction)sc_live_button_click:(id)sender{
	
	
	// load window from the main settings window
	
	NSButton *clicked = (NSButton *) sender;


	int myInt = (int)clicked.tag;
	
	

	

	 
	[self disable_buttons_view:myInt];
	
	
	[self function_load_camera_view:myInt];
	
	timer = [NSTimer scheduledTimerWithTimeInterval: timerInterval
											 target: self
										   selector:@selector(tick:)
										   userInfo: nil
											repeats: YES];
	// manage closing
}

-(void)function_popolate_menubar{
	
	
	//Remove old Status Scan Menu:
	[camera_sub_menu removeAllItems];
	
	
	
	if([camera_alias_array count] > 0){

		[cameras_menu_controller setEnabled:TRUE];
		
		
		if(thumbnails_size_h_saved != nil)
			
			{
			thumbnails_size_h.stringValue = thumbnails_size_h_saved;
			thumbnails_size_w.stringValue = thumbnails_size_w_saved;
			
			}else{
				
				thumbnails_size_h_saved = @"120";
				thumbnails_size_w_saved = @"200";
				
			}
		
		
		// *** Initialization of the menu bar
		// Creating a loop that add the cameras that are inside the alias loop
		
		// NSLog(@"[camera_alias_array count] , = %lu ",[camera_alias_array count] );
		
		
		int array_total = (int)[camera_alias_array count] -1;
		int i;
		
		for (i = array_total ; i >= 0; i--) {
			
		 NSLog(@"I ==  %i, Name = %@", i,camera_alias_array[i]);
			
			NSMenuItem *item = [camera_sub_menu insertItemWithTitle:camera_alias_array[i]  action:@selector(menulink:) keyEquivalent:@"" atIndex:0];
			[item setImage: [self function_get_image_from_id:i]];
			[item setTarget:self]; // or whatever target you want
			
		}
	
		
	}
	else{
		[cameras_menu_controller setEnabled:FALSE];
	}

	

	
}

-(void)update_menu_bar{
	
	
	int i=0;
	
	
		
	for( NSMenuItem *item in [camera_sub_menu itemArray] ){
		
		// // // NSLog(@"Updating ... = %@",item);
		[item setImage: [self function_get_image_from_id:i]];
		
		i++;
	}
	

}

-(void)function_preview_camera{
	
	
	[preview_image setImage:nil];
	
	NSString * camera_connection_string = 	[self function_get_camera_string_from_model:camera_model_combobox.stringValue];

	// Check if the IP contains URL
	
	
	NSString * temp_url;
	
	if ([camera_ip.stringValue containsString:@"http://"]) {
		
		NSString *url_withour_http = [camera_ip.stringValue stringByReplacingOccurrencesOfString:@"http://" withString:@""];

		camera_ip.stringValue = url_withour_http;
		
		
	}
	
	// check if authentication is enabled or not
	
	if([camera_username.stringValue isEqualToString:@""] || [camera_username.stringValue isEqualToString:@""] ){
		
		temp_url = [NSString stringWithFormat:@"http://%@%@", camera_ip.stringValue, camera_connection_string  ];
		
	// // // NSLog(@"No authentication");
		  
	}else{
		
		
		temp_url = [NSString stringWithFormat:@"http://%@:%@@%@:%@%@", camera_username.stringValue, camera_password.stringValue, camera_ip.stringValue, camera_port.stringValue, camera_connection_string  ];
		
		
		// // // NSLog(@"With authentication");
	}
	

	NSImage *newImage;
	NSURL *imageURL = [NSURL URLWithString:temp_url];
	
	NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
	if (imageData != nil) {
		newImage = [[NSImage alloc] initWithData:imageData];
		[newImage setSize: NSMakeSize(150,80)];
		[preview_image setImage: newImage];
		
		
	}else{
		NSString * private_key_msg = [NSString stringWithFormat:@"The current camera is offline. You should check the network "];
		NSAlert* msgBox = [[NSAlert alloc] init];
		[msgBox setMessageText:private_key_msg];
		[msgBox addButtonWithTitle: @"OK"];
		[msgBox runModal];
		
		return;
		
	}
	
	// // // NSLog(@"CAMERA URL --> %@", imageURL);
	
	
}

- (void)menulink:(id)sender {
	
	
	// load window with live from the menu bar

	
	NSMenuItem* mi = (NSMenuItem*)sender;
	
	NSUInteger index = [[[mi parentItem] submenu] indexOfItem:mi];
	
	// // // NSLog(@"Clicked item with index : %d",index);
	
	[self disable_buttons_view:index];
	
	[self function_load_camera_view:index];
	
	// // // NSLog(@"timerInterval = %f",timerInterval);
	
	timer = [NSTimer scheduledTimerWithTimeInterval: timerInterval
											 target: self
										   selector:@selector(tick:)
										   userInfo: nil
											repeats: YES];
}

- (IBAction)quit_button:(id)sender {
	
	// terminate the app
	[NSApp terminate:self];
	
}

- (IBAction)reset_all:(id)sender {
	
	// reset all the settings
	
	NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
	[[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    NSLog(@"resetall");
	
	
}

- (IBAction)show_preview:(id)sender {
	
	[self function_preview_camera];
}

-(void)function_load_model_list{
	
	[camera_model_combobox removeAllItems];
	[camera_brand_combobox removeAllItems];
	
	[brands_array removeAllObjects];
	[models_array removeAllObjects];
	[models_connection_string_array removeAllObjects];
	
	// get the entire list of all the cameras that are in the "camera_link" file
	

	// Parsing the local file to get the brand, the model and the connection string
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"local_camera_database" ofType:@"txt"];
	NSString *fileContents = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
	NSArray* rows = [fileContents componentsSeparatedByString:@"\n"];
	
	for (NSString *row in rows){
	
		// Splitting the row in three sub arrays
		// Row example "D-Link;DCS-5222L;/image/jpeg.cgi"
		// First row -> Brand, Second row -> Model, Third row -> connection string
		
		NSArray *row_array = [row componentsSeparatedByString:@";"];
		
		[brands_array addObject:row_array[0]];
		[models_array addObject:row_array[1]];
		[models_connection_string_array addObject:row_array[2]];

		
		
	}
	
	
	NSArray * unique_brand_array = [[brands_array valueForKeyPath:@"@distinctUnionOfObjects.self"] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	
	[camera_brand_combobox addItemsWithObjectValues:unique_brand_array];

}

-(void)function_load_model_list_from_url{
	
	// get the entire list of all the cameras that are in the "camera_link" file
	

	[camera_model_combobox removeAllItems];
	[camera_brand_combobox removeAllItems];
	
	[brands_array removeAllObjects];
	[models_array removeAllObjects];
	[models_connection_string_array removeAllObjects];
	
	// Parsing the local file to get the brand, the model and the connection string
	
	NSURL*url=[NSURL URLWithString:online_camera_db_url];
	
	// Get response from the update server webpage
	
	NSError *error;
	NSString *response_from_server_update = [NSString stringWithContentsOfURL:url
																	 encoding:NSASCIIStringEncoding
																		error:&error];
	


	NSArray* rows = [response_from_server_update componentsSeparatedByString:@"\n"];
	
	for (NSString *row in rows){
		
		
		
		
		// Splitting the row in three sub arrays
		// Row example "D-Link;DCS-5222L;/image/jpeg.cgi"
		// First row -> Brand, Second row -> Model, Third row -> connection string
		
		NSArray *row_array = [row componentsSeparatedByString:@";"];
		
		[brands_array addObject:row_array[0]];
		[models_array addObject:row_array[1]];
		[models_connection_string_array addObject:row_array[2]];
		
		
		
	}
	
	NSArray * unique_brand_array = [[brands_array valueForKeyPath:@"@distinctUnionOfObjects.self"] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
	
	[camera_brand_combobox addItemsWithObjectValues:unique_brand_array];


	
}

- (IBAction)add_camera:(id)sender {
	
	// add a camera button

	[self function_add_camera];
	// [self function_popolate_interface];
}

- (void)function_add_camera {
	

	
	
	// check if all the information are compiled
	// check if the model contains "Http", if yes -> autocompile the IP
	/*
	
	if ([[self function_get_camera_string_from_model:camera_model_combobox.stringValue] containsString:@"http://"]) {
		
		// // NSLog(@"contains HTTp");
		NSString* urlString = [self function_get_camera_string_from_model:camera_model_combobox.stringValue];
		NSURL* url = [NSURL URLWithString:urlString];
		NSString* domain = [url host];
		
		camera_ip.stringValue = domain;
		// // NSLog(@"domain = %@",domain);
	}
	
	*/
	
	if( [camera_model_combobox.stringValue isEqualToString: @""] || [camera_brand_combobox.stringValue isEqualToString: @""] || [camera_ip.stringValue isEqualToString: @""] || [camera_alias.stringValue isEqualToString: @""] ) {
  
		NSString * private_key_msg = [NSString stringWithFormat:@"Sorry, cannot save the information, you missed something"];
		NSAlert* msgBox = [[NSAlert alloc] init];
		[msgBox setMessageText:private_key_msg];
		[msgBox addButtonWithTitle: @"OK"];
		[msgBox runModal];
		
		return;
		
	}
	
	else{
	
		// Adding elemnts to the array only if they are corrects
		

		
		
	
		if ([camera_ip.stringValue containsString:@"http://"]) {
			
			NSString *temp_string = [camera_ip.stringValue stringByReplacingOccurrencesOfString:@"http://" withString:@""];

			[camera_url_array addObject:temp_string];
		
		} else {
		
			[camera_url_array addObject:camera_ip.stringValue];
			
		}
		
		[camera_alias_array addObject:camera_alias.stringValue];
		[camera_port_array addObject:camera_port.stringValue];
		[camera_username_array addObject:camera_username.stringValue];
		[camera_password_array addObject:camera_password.stringValue];
		[camera_brand_array addObject:camera_brand_combobox.stringValue];
		[camera_model_array addObject:camera_model_combobox.stringValue];
		
		// saving the arrays
		
		[[NSUserDefaults standardUserDefaults] setObject:camera_alias_array forKey:@"camera_alias_array"];
		[[NSUserDefaults standardUserDefaults] setObject:camera_url_array forKey:@"camera_url_array"];
		[[NSUserDefaults standardUserDefaults] setObject:camera_port_array forKey:@"camera_port_array"];
		[[NSUserDefaults standardUserDefaults] setObject:camera_username_array forKey:@"camera_username_array"];
		[[NSUserDefaults standardUserDefaults] setObject:camera_password_array forKey:@"camera_password_array"];
		[[NSUserDefaults standardUserDefaults] setObject:camera_brand_array forKey:@"camera_brand_array"];
		[[NSUserDefaults standardUserDefaults] setObject:camera_model_array forKey:@"camera_model_array"];
		[[NSUserDefaults standardUserDefaults] synchronize];
		
		[self function_popolate_interface];
	}
	
	// ** Hide windows at the end
	add_camera_window.isVisible = false;
	
	

}

-(void)function_popolate_interface{

	// NSLog(@"popolate interface");
	
	// *** Popolating comboboxs

	[camera_model_combobox removeAllItems];
	[camera_brand_combobox removeAllItems];
	
	NSArray * unique_brand_array = [[brands_array valueForKeyPath:@"@distinctUnionOfObjects.self"] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];

	[camera_brand_combobox addItemsWithObjectValues:unique_brand_array];
	


	fps_value_saved = [[NSUserDefaults standardUserDefaults] objectForKey:@"fps_value_saved"];
	fps_value_menu_saved  = [[NSUserDefaults standardUserDefaults] objectForKey:@"fps_value_menu_saved"];
	
	thumbnails_size_h_saved  = [[NSUserDefaults standardUserDefaults] objectForKey:@"thumbnails_size_h_saved"];
	thumbnails_size_w_saved  = [[NSUserDefaults standardUserDefaults] objectForKey:@"thumbnails_size_w_saved"];
	
	
	
	
	if(fps_value_menu_saved != nil)
		
		{
		
		menuInterval = fps_value_menu_saved.doubleValue;
		
		
		menu_label.stringValue = [NSString stringWithFormat:@"Reload Menu interval (%ld seconds)",(long)fps_value_menu_saved.integerValue];
		menu_slider.stringValue = fps_value_menu_saved;
		
		
		}
	
	if(fps_value_saved != nil)
		
		{
	
		timerInterval = fps_value_saved.doubleValue;
		
		
		fps_label.stringValue = [NSString stringWithFormat:@"Reload image interval (%ld seconds)",(long)fps_value_saved.integerValue];
		fps_slider.stringValue = fps_value_saved;
		
	
		}
	
	[self function_update_selectors];
	
	NSLog(@"fps_value_saved.integerValue = %ld",(long)fps_value_saved.integerValue);
	
	
	// * CALLING THREAD
	// calling the popolating menu bar function using a new thread
	 if([camera_alias_array count] != 0){
		
			[self performSelectorInBackground:@selector(function_popolate_scrollview) withObject:nil];
		
	}
	
	if([camera_alias_array count] == 0){
		
		// NSLog(@"It's here !!");
		[self function_remove_thumbail:0];

	}
	
	[self performSelectorInBackground:@selector(function_popolate_menubar) withObject:nil];
	

}

-(NSImage *)function_get_image_from_id:(NSInteger)camera_model_id{
NSLog(@"camera_model_id = %ld",(long)camera_model_id);

 @try {
		
	 NSString *  camera_url = [self function_get_camera_url_from_id:camera_model_id];
	 
	 
	 NSImage *newImage;
	 NSURL *imageURL = [NSURL URLWithString:camera_url];
	 
	 
	 
	 NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
	 if (imageData != nil) {
		 newImage = [[NSImage alloc] initWithData:imageData];
		 // thumb size
		 [newImage setSize: NSMakeSize(thumbnails_size_w_saved.integerValue,thumbnails_size_h_saved.integerValue)];
		 
		 
	 }else{
		 newImage = [NSImage imageNamed:@"webcam-offline.jpg"];
		 // thumb size
		 [newImage setSize: NSMakeSize(thumbnails_size_w_saved.integerValue,thumbnails_size_h_saved.integerValue)];
		 
	 }
	 
	 
	 return newImage;
 }
 @catch (NSException * e) {
	 // NSLog(@"Exception: %@", e);
 }
 @finally {
	 // NSLog(@"Error in the get of the url");
 }

	
}

-(void)function_update_selectors{
	
	// Update the slider if you change their values
	
	if(fps_slider.integerValue>=1 && fps_slider.integerValue<=2){
		reflashinterval_selector_value.selectedSegment = 0;
	}
	
	if(fps_slider.integerValue>=3 && fps_slider.integerValue<=5){
		reflashinterval_selector_value.selectedSegment = 1;
	}
	if(fps_slider.integerValue>=6 && fps_slider.integerValue<=10){
		reflashinterval_selector_value.selectedSegment = 2;
	}
	
	
	
	if(menu_slider.integerValue>=1 && menu_slider.integerValue<=60){
		reflashmenu_selector_value.selectedSegment = 0;
	}
	
	if(menu_slider.integerValue>=61 && menu_slider.integerValue<=300){
		reflashmenu_selector_value.selectedSegment = 1;
	}
	if(menu_slider.integerValue>=301 && menu_slider.integerValue<=600){
		reflashmenu_selector_value.selectedSegment = 2;
	}
	
	
	NSLog(@" ps_value_saved.integerValue> = %ld",(long)fps_value_saved.integerValue);
}

- (NSString *)function_get_camera_url_from_id:(NSInteger)id{
	
	@try {
		NSString *  camera_url;
		
		// get url from id
		
		NSString * camera_connection_string = 	[self function_get_camera_string_from_model:camera_model_array[id]];
		// NSLog(@"camera_connection_string = %@",camera_connection_string);
		
		if( [camera_username_array[id] isEqualToString:@""]){
			
			camera_url = [NSString stringWithFormat:@"http://%@:%@%@", camera_url_array[id],camera_port_array[id], camera_connection_string  ];
			
		}else{
			
			camera_url = [NSString stringWithFormat:@"http://%@:%@@%@:%@%@", camera_username_array[id], camera_password_array[id], camera_url_array[id],camera_port_array[id], camera_connection_string  ];
			
		}
		
		// NSLog(@"camera_url = %@",camera_url);
		
		return camera_url;
		
 }
 @catch (NSException * e) {
	 // NSLog(@"Exception: %@", e);
 }
 @finally {
	 // NSLog(@"Everything is OK");
 }
	
	
	
	
}

- (NSString *)function_get_camera_string_from_model:(NSString *)model{
	
	// Get the string of the selected model
	
	
	// // // NSLog(@"MODEL == %@", model);
	
	NSInteger index_of_the_model = [models_array indexOfObjectIdenticalTo:model];
	
	// // // NSLog(@"Index of model = %lu", (unsigned long)index_of_the_model);
	// // NSLog(@"String = %@", [models_connection_string_array objectAtIndex:index_of_the_model]);
	// // NSLog(@"model = %@", model);
	
	return [models_connection_string_array objectAtIndex:index_of_the_model];

	
}

- (NSInteger)function_get_id_from_alias:(NSString *)alias{
	
	// Get the string of the selected model
	
	// // // NSLog(@"ALIAS == %@", alias);
	
	NSInteger index_of_the_model = [models_array indexOfObjectIdenticalTo:alias];

	return index_of_the_model;
	
	
}

- (NSString *)function_get_alias__from_id:(NSInteger)id{
	
	// get url from id


	return camera_alias_array[id];
	
}

- (void)tick:(NSTimer *)theTimer {
	
	// reflashing the images
	
	 [NSThread detachNewThreadSelector:@selector(fuction_reflash_cameras_images) toTarget:self withObject:nil];

}

-(void)function_load_camera_view:(NSInteger)id{
	
	// called after the clikc on the live button of the cameras/menu button

	temp_camera_id = id;
	
	
	
	NSString * camera_name =[self function_get_alias__from_id:id];
	NSString *  camera_url = [self function_get_camera_url_from_id:id];

	
	self.myWindow= [[NSPanel alloc] initWithContentRect:NSMakeRect(100,100,500,250)
					//styleMask:NSTitledWindowMask| NSClosableWindowMask |NSResizableWindowMask
											  styleMask:NSHUDWindowMask | NSClosableWindowMask | NSTitledWindowMask | NSUtilityWindowMask /* | NSResizableWindowMask */
					
												 backing:NSBackingStoreBuffered
												   defer:NO];
	

	float windownumber = self.myWindow.windowNumber;
	
	
	[self.myWindowArray addObject:self.myWindow];
	[self.myWindowArray_name addObject:camera_name];
	[self.myWindowArray_url_image addObject:camera_url];
	
	[self.myWindowArray_windownumber addObject: [NSNumber numberWithInt:windownumber]];
	
	
	[self function_show_camera_windows];
	
	NSLog(@"myWindowArray_windownumber = %@",myWindowArray_windownumber);
	NSLog(@"myWindowArray = %@",myWindowArray);
	NSLog(@"myWindowArray_name = %@",myWindowArray_name);
	NSLog(@"myWindowArray_url_image = %@",myWindowArray_url_image);
	
}

-(void)function_show_camera_windows{
	
	// creation of the windows environment

	int i=0;
	
	for (NSWindow *win in self.myWindowArray) {
		
		[win makeKeyAndOrderFront:NSApp];
		[win setTitle:[self.myWindowArray_name objectAtIndex:i]];

		[win makeKeyAndOrderFront:nil];
		[win setLevel:NSStatusWindowLevel];
		[win setHidesOnDeactivate:false];
		// creation of the images
		
		NSImageView *subview = [[NSImageView alloc] initWithFrame:CGRectMake(0,0 ,500, 250)];
		NSString *  camera_url = [self.myWindowArray_url_image objectAtIndex:i];
		
		
		NSImage *newImage;
		NSURL *imageURL = [NSURL URLWithString:camera_url];
		
		NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
		if (imageData != nil) {
			newImage = [[NSImage alloc] initWithData:imageData];
			// thumb size
			//[newImage setSize: NSMakeSize(400, 200)];
			
		}else{
			newImage = [NSImage imageNamed:@"webcam-offline.jpg"];
			// thumb size
			//[newImage setSize: NSMakeSize(400, 200)];
			
		}
		
		[subview setImage:newImage];
		[subview setAutoresizingMask:NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin];
		[subview setTag:i];
		[[win contentView] setAutoresizesSubviews:YES];
		[subview setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
		
		// need to know when and what window is closed
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowWillClose:) name:NSWindowWillCloseNotification object:win];
		
		[[win contentView] setWantsLayer:YES];
		[[win contentView] addSubview:subview];
		
		
		i++;
		
	}
}

-(void)function_remove_window_from_array:(int)id{
	
	
	NSLog(@"Try to close the window = %i",id);
	
	NSString * index_string = [NSString stringWithFormat:@"%i",id];
	NSLog(@"window = %@",index_string);

	
	
	int i ;
	
	
	for (i = 0; i < [myWindowArray_windownumber count] ; i++) {
		
	
		int intvalue = [[myWindowArray_windownumber objectAtIndex:i] intValue]; // this is the ID of the window (like 48992)
	
		
		
		if(id == intvalue){
			
			
			
			NSLog(@"tag to be enable  = %@",[myWindowArray_tag objectAtIndex:i]);
			
			int tag_to_be_enabled = [[myWindowArray_tag objectAtIndex:i] intValue];
			
			[self enable_buttons_view:tag_to_be_enabled];
			//	NSLog(@"tag to be enable = %i",i);
			
			[myWindowArray removeObjectAtIndex:i];
			[myWindowArray_name removeObjectAtIndex:i];
			[myWindowArray_url_image removeObjectAtIndex:i];
			[myWindowArray_windownumber removeObjectAtIndex:i];
			[myWindowArray_tag removeObjectAtIndex:i];
		}
		
	}
	

	
}

-(void)fuction_reflash_cameras_images{
	
	int i=0;
	
	for (NSWindow *win in self.myWindowArray) {
	
		
		// ADD IMAGE
		
		NSImageView *subview = [[NSImageView alloc] initWithFrame:CGRectMake(0,0 ,500, 250)];
		NSString *  camera_url = [self.myWindowArray_url_image objectAtIndex:i];
		
		[subview removeFromSuperview];
		
		NSImage *newImage;
		NSURL *imageURL = [NSURL URLWithString:camera_url];
		
		NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
		if (imageData != nil) {
			newImage = [[NSImage alloc] initWithData:imageData];
			// thumb size
			//[newImage setSize: NSMakeSize(400, 200)];
			
			
	

			
			
		}else{
			newImage = [NSImage imageNamed:@"webcam-offline.jpg"];
			// thumb size
			//[newImage setSize: NSMakeSize(400, 200)];
			
		}
		
		
		[subview setImage:newImage];
		[subview setAutoresizingMask:NSViewMinXMargin | NSViewMaxXMargin | NSViewMinYMargin | NSViewMaxYMargin];
		[subview setTag:i];
		[[win contentView] setAutoresizesSubviews:YES];
		[subview setAutoresizingMask:NSViewWidthSizable | NSViewHeightSizable];
		
		[[win contentView] setWantsLayer:YES];
		[[win contentView] addSubview:subview];
		
		
		i++;
		
	}

	
}

-(void)disable_buttons_view:(NSInteger)id{
	
	[myWindowArray_tag addObject:[NSNumber numberWithInt:id]];
	
	// disable the "live" and "delete" button from the scroll view
	
	int i =0;
	
	for (NSImageView* view in self.cameras_dynamic_scrollview.subviews ) {
	
		if([view isKindOfClass:[NSButton class]]){
		
			if(view.tag == id){
				NSLog(@"DISABLE BUTTON WITH TAG %li", (long)view.tag);
				[view setEnabled:FALSE];
			}
			
		}
		
		i++;
		
	}

}

-(void)enable_buttons_view:(NSInteger)id{
	
	
	
	// enable the "live" and "delete" button from the scroll view
	
	int i =0;
	
	for (NSImageView* view in self.cameras_dynamic_scrollview.subviews ) {
	
		if([view isKindOfClass:[NSButton class]]){
			
			if(view.tag == id){
				NSLog(@"ENABLE BUTTON WITH TAG %li", (long)view.tag);
				[view setEnabled:TRUE];
			}
			
		}
		
		i++;
		
	}
	
}

- (IBAction)show_layout:(id)sender {
	NSLog(@"myWindowArray_tag = %@",myWindowArray_tag);
}

- (void)windowWillClose:(NSNotification *)notification {
	
	[timer invalidate];
	 timer = nil;

	// handle the closing of the application and get all the information that I need to delete it from the nswindow array
	
	
	NSWindow *win = [notification object];
	//NSString * name = win.title;
	
	//NSInteger * index = win.windowNumber ;
	
	float windownumber = win.windowNumber;
	
	[self function_remove_window_from_array:windownumber];
	
	
	
}

-(void)function_delete_camera:(NSInteger)id{
	
	 // NSLog(@"Request of delete for camera %ld",(long)id);
	
	// remove the camera from the list
	
	[camera_alias_array removeObjectAtIndex:id];
	[camera_url_array removeObjectAtIndex:id];
	[camera_port_array removeObjectAtIndex:id];
	[camera_username_array removeObjectAtIndex:id];
	[camera_password_array removeObjectAtIndex:id];
	[camera_brand_array removeObjectAtIndex:id];
	[camera_model_array removeObjectAtIndex:id];
	
	
}

-(void)function_save{
	
	// save pendings values
	
	[[NSUserDefaults standardUserDefaults] setObject:camera_alias_array forKey:@"camera_alias_array"];
	[[NSUserDefaults standardUserDefaults] setObject:camera_url_array forKey:@"camera_url_array"];
	[[NSUserDefaults standardUserDefaults] setObject:camera_port_array forKey:@"camera_port_array"];
	[[NSUserDefaults standardUserDefaults] setObject:camera_username_array forKey:@"camera_username_array"];
	[[NSUserDefaults standardUserDefaults] setObject:camera_password_array forKey:@"camera_password_array"];
	[[NSUserDefaults standardUserDefaults] setObject:camera_brand_array forKey:@"camera_brand_array"];
	[[NSUserDefaults standardUserDefaults] setObject:camera_model_array forKey:@"camera_model_array"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	// // // NSLog(@"Saving data ...");
	

	
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {

	//save data
	[self function_save];
	// close connections with cameras
}

- (IBAction)fps_slider_action:(id)sender {
	
	NSInteger know_vale = fps_slider.stringValue.integerValue;
	fps_label.stringValue = [NSString stringWithFormat:@"Reload image interval (%ld seconds)",(long)know_vale];

	[[NSUserDefaults standardUserDefaults] setObject:fps_slider.stringValue forKey:@"fps_value_saved"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	timerInterval = fps_slider.doubleValue;
	
	[self function_update_selectors];
	
	
}

- (IBAction)menu_slider_action:(id)sender {
	
	NSInteger know_vale = menu_slider.stringValue.integerValue;
	menu_label.stringValue = [NSString stringWithFormat:@"Reload menu interval (%ld seconds)",(long)know_vale];

	
	[[NSUserDefaults standardUserDefaults] setObject:menu_slider.stringValue forKey:@"fps_value_menu_saved"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	menuInterval = menu_slider.doubleValue;

	[self function_update_selectors];
}

- (IBAction)choose_brand_action:(id)sender {
	
	// filter the model based on the brand
	
	

	NSMutableArray * filter_model_array;
	
	filter_model_array = [[NSMutableArray alloc] init];
	
	int i;
	for (i = 0; i < [models_array count]; i++) {
	
		
		if([[brands_array objectAtIndex:i] isEqualToString:camera_brand_combobox.stringValue]){
			
			[filter_model_array addObject:[models_array objectAtIndex:i]];
			
			// // // NSLog(@" models_array=  %@",[models_array objectAtIndex:i]);
			
		}else{
			
		}
		
		
	}

	
	// clean and populate
	
	[camera_model_combobox setEnabled:TRUE];
	
	[camera_model_combobox removeAllItems];
	[camera_model_combobox addItemsWithObjectValues:filter_model_array];
	[camera_model_combobox selectItemAtIndex:0];
	
}

- (IBAction)internal_db_btn:(id)sender {
	
	[self function_load_model_list];
	// // // NSLog(@"Internal DB");
}

- (IBAction)external_db_btn:(id)sender {
	
	[self function_load_model_list_from_url];
}

- (IBAction)thumbnails_size_action:(id)sender {
	
	
	NSInteger  width = thumbnails_size_w.integerValue;
	
	// NSInteger height = thumbnails_size_h.integerValue;
	
	NSInteger proportion = [self fuction_proportion_thumbnails_size:width];
	
	
	thumbnails_size_h.stringValue = [NSString stringWithFormat:@"%li",(long)proportion];
	
	[[NSUserDefaults standardUserDefaults]  setObject:thumbnails_size_h.stringValue forKey:@"thumbnails_size_h_saved"]; // check ping
	[[NSUserDefaults standardUserDefaults]  setObject:thumbnails_size_w.stringValue forKey:@"thumbnails_size_w_saved"]; // check ping

	
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	
	
	
}

- (int)fuction_proportion_thumbnails_size:(int)width{

	NSInteger proportion = width * 0.6;
	return proportion;
	
	
}

-(void)function_remove_thumbail:(NSInteger)id{
	
	// NSLog(@"id to be deleted = %li",(long)id);
	
	NSView *removeView;
	while((removeView = [self.cameras_dynamic_scrollview viewWithTag:id]) != nil) {
		[removeView removeFromSuperview];
	}
	
}

-(void)function_clean_scrollview{
	
	
	int i ;
	
	
	for (i = 0; i < [camera_alias_array count] * 4; i++) {
		
		[self function_remove_thumbail:i];
		
	}

}

- (IBAction)test_btn:(id)sender {
	



}

- (IBAction)settings_menu_btn:(id)sender {

	[home_window makeKeyAndOrderFront:self];
}

- (IBAction)thumbnail_size_selector:(id)sender {
	
	
	
	if(thumbnail_size_value.selectedSegment == 0){
		
	thumbnails_size_w.stringValue = @"100";
		
	}
	if(thumbnail_size_value.selectedSegment == 1){
		
		
		thumbnails_size_w.stringValue = @"200";
		
	}
	if(thumbnail_size_value.selectedSegment == 2){
		
		
	thumbnails_size_w.stringValue = @"300";
		
	}
	NSInteger  width = thumbnails_size_w.integerValue;
	
	
	NSInteger proportion = [self fuction_proportion_thumbnails_size:width];
	
	
	thumbnails_size_h.stringValue = [NSString stringWithFormat:@"%li",(long)proportion];

	
	[[NSUserDefaults standardUserDefaults]  setObject:thumbnails_size_h.stringValue forKey:@"thumbnails_size_h_saved"]; // check ping
	[[NSUserDefaults standardUserDefaults]  setObject:thumbnails_size_w.stringValue forKey:@"thumbnails_size_w_saved"]; // check ping
	
	
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	thumbnails_size_h_saved  = [[NSUserDefaults standardUserDefaults] objectForKey:@"thumbnails_size_h_saved"];
	thumbnails_size_w_saved  = [[NSUserDefaults standardUserDefaults] objectForKey:@"thumbnails_size_w_saved"];
	

	
	[self performSelectorInBackground:@selector(function_popolate_menubar) withObject:nil];

}

- (IBAction)reflashmenu_selector:(id)sender {
	
	
	
	if(reflashmenu_selector_value.selectedSegment == 0){
		
		menu_slider.stringValue = @"60";
		
	}
	if(reflashmenu_selector_value.selectedSegment == 1){
		
		
		menu_slider.stringValue = @"300";
		
	}
	if(reflashmenu_selector_value.selectedSegment == 2){
		
		
		menu_slider.stringValue = @"600";
		
	}
	
	// populating the bar label
	
	NSInteger know_vale = menu_slider.stringValue.integerValue;
	menu_label.stringValue = [NSString stringWithFormat:@"Reload menu interval (%ld seconds)",(long)know_vale];

	// save settings
	
	[[NSUserDefaults standardUserDefaults] setObject:menu_slider.stringValue forKey:@"fps_value_menu_saved"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	[self function_save];

}

- (IBAction)reflashinterval_selector:(id)sender {
	
	if(reflashinterval_selector_value.selectedSegment == 0){
		
		fps_slider.stringValue = @"2";
		
	}
	if(reflashinterval_selector_value.selectedSegment == 1){
		
		
		fps_slider.stringValue = @"5";
		
	}
	if(reflashinterval_selector_value.selectedSegment == 2){
		
		
		fps_slider.stringValue = @"10";
		
	}
	
	// populating the bar label
	
	NSInteger know_vale = fps_slider.stringValue.integerValue;
	fps_label.stringValue = [NSString stringWithFormat:@"Reload image interval (%ld seconds)",(long)know_vale];

	// save settings
	
	[[NSUserDefaults standardUserDefaults] setObject:fps_slider.stringValue forKey:@"fps_value_saved"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	[self function_save];
}

- (IBAction)reload_scroll_view_button:(id)sender {
	
		[self performSelectorInBackground:@selector(function_popolate_scrollview) withObject:nil];
}

- (IBAction)save_snapshosts:(id)sender {
	
	
	[self performSelectorInBackground:@selector(function_saveallsnapshot) withObject:nil];
}

-(void)function_saveallsnapshot{
	
	// save snapshot for all the thumbnails
	
	int i;
	
	for (i = 0; i < [camera_alias_array count]; i++) {
		
		NSString *  camera_url = [self function_get_camera_url_from_id:i];
		
		
		NSImage *newImage;
		NSURL *imageURL = [NSURL URLWithString:camera_url];
		
		NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
		if (imageData != nil) {
			newImage = [[NSImage alloc] initWithData:imageData];
			// thumb size
					}else{
			newImage = [NSImage imageNamed:@"webcam-offline.jpg"];
			// thumb size
			
		}
	
		// get the date and the time
		
		NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
		[dateFormatter setDateFormat:@"yyyy-MM-dd-HH-MM-ss"];
		NSLog(@"%@",[dateFormatter stringFromDate:[NSDate date]]);
		
		
		
		newImage = [[NSImage alloc] initWithData:imageData];
		
		// Write to JPG
		imageData = [newImage  TIFFRepresentation];
		NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
		NSDictionary *imageProps = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:0.9] forKey:NSImageCompressionFactor];
		imageData = [imageRep representationUsingType:NSJPEGFileType properties:imageProps];
		
		NSString * url = [NSString stringWithFormat:@"%@screenshot-%@-%@.jpg",folder_saved,[dateFormatter stringFromDate:[NSDate date]],camera_alias_array [i]];
		
		NSLog(@"url = %@",url);
		[imageData writeToFile:url atomically:NO];
		
		
		// output is like screenshot-2015-09-14-19-09-08-Apple 3
	}
	
}

- (IBAction)folder_action:(id)sender {
	
	// neet to remove file:///
	
	NSString * temp = [folder_control.stringValue stringByReplacingOccurrencesOfString:@"file:///" withString:@"/"];
	
	[[NSUserDefaults standardUserDefaults] setObject:temp forKey:@"folder_saved"];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	folder_label.stringValue = temp;
	

}
@end
