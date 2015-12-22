function varargout = gui(varargin)
% GUI MATLAB code for gui.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before gui_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to gui_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help gui

% Last Modified by GUIDE v2.5 20-Mar-2015 18:31:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;

gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @gui_OpeningFcn, ...
                   'gui_OutputFcn',  @gui_OutputFcn, ...
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




% --- Executes just before gui is made visible.
function gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to gui (see VARARGIN)

% Choose default command line output for gui
handles.output = hObject;

%values trained from db, 
%rows = feature 1,..3; cols = avg, sigma
handles.paint = [.247393, .134492;...
                 .011359, .002757; ...
                 .662101, .054013];
handles.photo = [.019734, .012414;...
                .005657, .001472; ...
                .516688, .093757]; 
handles.threshold = [ getThreshold(handles.paint(1,:), handles.photo(1,:)),...
            getThreshold(handles.paint(2,:), handles.photo(2,:)),...
            getThreshold(handles.paint(3,:), handles.photo(3,:))];
        set(handles.uitable5, 'data', handles.threshold')
axis off;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = gui_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[i_file,i_PathName] = uigetfile({'*.jpg', 'JPEG imagefile(*.jpg)'; '*.*', 'All Files (*.*)'},...
    'Select the JPEG Image',[cd '\']); 
if ~isequal(i_file, 0)
    % Reading the Image file
    i_file = fullfile(i_PathName,i_file);
    handles.image = imread(i_file);
    handles.image = im2double(handles.image);
end
axes(handles.axes1);
imshow(handles.image);
vals = getFeatures(handles.image); 
res = classifyImage(vals, handles.paint, handles.threshold);
msg = 'Input image is ';
if (res == 1) 
    msg = strcat(msg, ' Painting');
else
    msg = strcat(msg, ' Photograph');
end
msgbox(msg, 'Results')
set(handles.uitable4, 'data', vals');
guidata(hObject, handles);


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%this is painting
 set(handles.pushbutton3, 'String', 'Wait...');
handles.paint = getTrainData();

set(handles.uitable3, 'data', handles.paint);
guidata(hObject, handles);
handles.threshold = [ getThreshold(handles.paint(1,:), handles.photo(1,:)),...
            getThreshold(handles.paint(2,:), handles.photo(2,:)),...
            getThreshold(handles.paint(3,:), handles.photo(3,:))];
set(handles.uitable5, 'data', handles.threshold')
 set(handles.pushbutton3, 'String', 'Set Folder');
beep

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%this is photograph
 set(handles.pushbutton2, 'String', 'Wait...')
handles.photo = getTrainData();
set(handles.uitable2, 'data', handles.photo);
guidata(hObject, handles);
handles.threshold = [ getThreshold(handles.paint(1,:), handles.photo(1,:)),...
            getThreshold(handles.paint(2,:), handles.photo(2,:)),...
            getThreshold(handles.paint(3,:), handles.photo(3,:))];
 set(handles.uitable5, 'data', handles.threshold')
 beep
  set(handles.pushbutton2, 'String', 'Set Folder')
