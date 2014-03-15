function varargout = test_image(varargin)
% TEST_IMAGE M-file for test_image.fig
%      TEST_IMAGE, by itself, creates a new TEST_IMAGE or raises the existing
%      singleton*.
%
%      H = TEST_IMAGE returns the handle to a new TEST_IMAGE or the handle to
%      the existing singleton*.
%
%      TEST_IMAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TEST_IMAGE.M with the given input arguments.
%
%      TEST_IMAGE('Property','Value',...) creates a new TEST_IMAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before test_image_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to test_image_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help test_image

% Last Modified by GUIDE v2.5 27-Feb-2014 14:42:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @test_image_OpeningFcn, ...
    'gui_OutputFcn',  @test_image_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before test_image is made visible.
function test_image_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test_image (see VARARGIN)

% Choose default command line output for test_image
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test_image wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_image_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in selectImageButton.
function selectImageButton_Callback(hObject, eventdata, handles)
% hObject    handle to selectImageButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%[filename pathname] = uigetfile({'*.jpg'}, 'File Selector');
%fullpathname = strcat(pathname,filename);
%image = fileread(fullpathname);

global originalImage;

[pathname, userCanceled] = imgetfile;
if userCanceled
    return;
end

hideSliders(handles);
hideCannySliders(handles);

originalImage = imread(pathname);

modifiedImage = originalImage;

axes(handles.originalAxes);
imshow(originalImage);
axes(handles.modifiedAxes);
imshow(originalImage);

% --- Executes on button press in resetButton.
function resetButton_Callback(hObject, eventdata, handles)
% hObject    handle to resetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originalImage modifiedImage;


hideSliders(handles);
hideCannySliders(handles);

modifiedImage = originalImage;
axes(handles.modifiedAxes);
imshow(modifiedImage);

% --------------------------------------------------------------------
function menu_noise_filters_Callback(hObject, eventdata, handles)
% hObject    handle to menu_noise_filters (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menu_basic_ops_Callback(hObject, eventdata, handles)
% hObject    handle to menu_basic_ops (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function bo_grayscale_Callback(hObject, eventdata, handles)
% hObject    handle to bo_grayscale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global originalImage modifiedImage;

hideSliders(handles);
hideCannySliders(handles);

modifiedImage = rgb2gray(originalImage);
axes(handles.modifiedAxes);
imshow(modifiedImage);


% --------------------------------------------------------------------
function bo_negative_Callback(hObject, eventdata, handles)
% hObject    handle to bo_negative (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originalImage modifiedImage;

hideSliders(handles);
hideCannySliders(handles);

modifiedImage = 255-originalImage;
axes(handles.modifiedAxes);
imshow(modifiedImage);


% --- Executes on button press in rotateRightBtn.
function rotateRightBtn_Callback(hObject, eventdata, handles)
% hObject    handle to rotateRightBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global modifiedImage;

hideSliders(handles);
hideCannySliders(handles);

modifiedImage = imrotate(modifiedImage,-90);
axes(handles.modifiedAxes);
imshow(modifiedImage);


% --- Executes on button press in rotateLeftBtn.
function rotateLeftBtn_Callback(hObject, eventdata, handles)
% hObject    handle to rotateLeftBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global modifiedImage;

hideSliders(handles);
hideCannySliders(handles);

modifiedImage = imrotate(modifiedImage,90);
axes(handles.modifiedAxes);
imshow(modifiedImage);


% --------------------------------------------------------------------
function bo_mirror_Callback(hObject, eventdata, handles)
% hObject    handle to bo_mirror (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global modifiedImage;

hideSliders(handles);
hideCannySliders(handles);

modifiedImage = flipdim(modifiedImage,2);      %# Flips the columns, making a mirror image
axes(handles.modifiedAxes);
imshow(modifiedImage);


% --------------------------------------------------------------------
function menu_edge_detection_Callback(hObject, eventdata, handles)
% hObject    handle to menu_edge_detection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function slider_thresh_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_thresh_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function slider_min_thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_min_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes during object creation, after setting all properties.
function slider_max_thresh_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider_max_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on slider movement.
function slider_thresh_1_Callback(hObject, eventdata, handles)
% hObject    handle to slider_thresh_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global modifiedImage;
sliderValue = get(handles.slider_thresh_1,'Value');
sliderValue = round(sliderValue);
set(handles.text_thresh_1,'String', num2str(sliderValue));

edge_threshold(modifiedImage,sliderValue,handles)


% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes on slider movement.
function slider_min_thresh_Callback(hObject, eventdata, handles)
% hObject    handle to slider_min_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global modifiedImage threshMin threshMax;

sliderValue = get(handles.slider_min_thresh,'Value');
sliderValue = round(sliderValue);

if(sliderValue > threshMax)
    threshMax = min(sliderValue+10,255);
    set(handles.slider_max_thresh,'Value',threshMax);
    set(handles.text_max_thresh, 'String',threshMax);
end

threshMin = sliderValue;

set(handles.text_min_thresh,'String', num2str(sliderValue));

canny_edge_threshold(modifiedImage,handles)


% --- Executes on slider movement.
function slider_max_thresh_Callback(hObject, eventdata, handles)
% hObject    handle to slider_max_thresh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global modifiedImage threshMax threshMin;

sliderValue = get(handles.slider_max_thresh,'Value');
sliderValue = round(sliderValue);

if(sliderValue < threshMin)
    threshMin = max(sliderValue-10,0);
    set(handles.slider_min_thresh,'Value',threshMin);
    set(handles.text_min_thresh, 'String',threshMin);
end

threshMax = sliderValue;

set(handles.text_max_thresh,'String', num2str(sliderValue));

canny_edge_threshold(modifiedImage,handles)

% --------------------------------------------------------------------
function edge_sobel_threshold(modifiedImage,thresh,handles)
%Define a threshold value
edgeImage = max(modifiedImage,thresh);
edgeImage(edgeImage==round(thresh))= 0;

edgeImage = uint8(edgeImage);
axes(handles.modifiedAxes);
imshow(edgeImage);


% --------------------------------------------------------------------
function edge_threshold(modifiedImage,thresh,handles)
%Define a threshold value
edgeImage = modifiedImage;
iSize = size(modifiedImage);
for X = 1:iSize(1),
    for Y = 1:iSize(2),
        if modifiedImage(X,Y) >= thresh;
            edgeImage(X,Y) = 255;
        else
            edgeImage(X,Y) = 0;
        end
    end
end
edgeImage = uint8(edgeImage);
axes(handles.modifiedAxes);
imshow(edgeImage);

% --------------------------------------------------------------------
function canny_edge_threshold(modifiedImage,handles)
global threshMax threshMin;

edgeImage = modifiedImage;

[r c]=size(edgeImage);
resimg(r,c)= 0;

for u = 2 : r-1
    for v = 2 : c-1
        if(edgeImage(u,v) > threshMax)
            resimg(u,v) = 255;
        else
            if(edgeImage(u,v) >= threshMin && edgeImage(u,v) <= threshMax )
                resimg(u,v) = 255;
            else
                if (edgeImage(u,v) < threshMin)
                    resimg(u,v) = 0;
                end
            end
        end
        
        if (edgeImage(u-1,v-1) > threshMax || edgeImage(u,v-1) > threshMax || edgeImage(u+1,v-1) > threshMax || edgeImage(u+1,v) > threshMax || edgeImage(u+1,v+1) > threshMax || edgeImage(u,v+1) > threshMax || edgeImage(u-1,v+1) > threshMax || edgeImage(u-1,v) > threshMax)
            resimg(u,v) = 255;
        else
            resimg(u,v) = 0;
        end
    end
end

edgeImage = uint8(resimg);
axes(handles.modifiedAxes);
imshow(edgeImage);

% --------------------------------------------------------------------
function hideSliders(handles)
global isThreshSliderVisible;
isThreshSliderVisible = false;
set(handles.slider_thresh_1, 'visible','off');
set(handles.text_thresh_1, 'visible','off');
set(handles.text_thresh_label, 'visible','off');

% --------------------------------------------------------------------
function hideCannySliders(handles)
global isCannySlidersVisible;
isCannySlidersVisible = false;
set(handles.canny_panel, 'visible','off');


% --------------------------------------------------------------------
function edge_sobel_Callback(hObject, eventdata, handles)
% hObject    handle to edge_sobel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originalImage modifiedImage isThreshSliderVisible;
thresh = 100;

hideCannySliders(handles);

if (isThreshSliderVisible == false)
    set(handles.slider_thresh_1, 'visible','on');
    set(handles.text_thresh_1, 'visible','on');
    set(handles.text_thresh_label, 'visible','on');
    
    isThreshSliderVisible = true;
end

set(handles.slider_thresh_1,'Value',thresh);
set(handles.text_thresh_1, 'String',thresh);

modifiedImage = rgb2gray(originalImage);
modifiedImage = edge_sobel(modifiedImage);
%edge_sobel_threshold(modifiedImage,thresh,handles)
edge_threshold(modifiedImage,thresh,handles)

% --------------------------------------------------------------------
function edge_prewitt_Callback(hObject, eventdata, handles)
% hObject    handle to edge_prewitt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global originalImage modifiedImage isThreshSliderVisible;
thresh = 100;

hideCannySliders(handles);

if (isThreshSliderVisible == false)
    set(handles.slider_thresh_1, 'visible','on');
    set(handles.text_thresh_1, 'visible','on');
    set(handles.text_thresh_label, 'visible','on');
    
    isThreshSliderVisible = true;
end

set(handles.slider_thresh_1,'Value',thresh);
set(handles.text_thresh_1, 'String',thresh);

modifiedImage = rgb2gray(originalImage);
modifiedImage = edge_prewitt(modifiedImage);
edge_threshold(modifiedImage,thresh,handles);


% --------------------------------------------------------------------
function edge_roberts_Callback(hObject, eventdata, handles)
% hObject    handle to edge_roberts (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global originalImage modifiedImage isThreshSliderVisible;
thresh = 100;

hideCannySliders(handles);

if (isThreshSliderVisible == false)
    set(handles.slider_thresh_1, 'visible','on');
    set(handles.text_thresh_1, 'visible','on');
    set(handles.text_thresh_label, 'visible','on');
    
    isThreshSliderVisible = true;
end
set(handles.slider_thresh_1,'Value',thresh);
set(handles.text_thresh_1, 'String',thresh);

modifiedImage = rgb2gray(originalImage);
modifiedImage = edge_roberts(modifiedImage);
edge_threshold(modifiedImage,thresh,handles);


% --------------------------------------------------------------------
function edge_canny_Callback(hObject, eventdata, handles)
% hObject    handle to edge_canny (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global originalImage modifiedImage isCannySlidersVisible threshMax threshMin;

threshMax = 100;
threshMin = 95;

hideSliders(handles);

if (isCannySlidersVisible == false)
    set(handles.canny_panel, 'visible','on');
    isCannySlidersVisible = true;
end
set(handles.slider_max_thresh,'Value',threshMax);
set(handles.slider_min_thresh,'Value',threshMin);
set(handles.text_max_thresh, 'String',threshMax);
set(handles.text_min_thresh, 'String',threshMin);

modifiedImage = rgb2gray(originalImage);
modifiedImage = edge_canny(modifiedImage);
canny_edge_threshold(modifiedImage,handles);
