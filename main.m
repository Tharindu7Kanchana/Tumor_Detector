function varargout = main(varargin)
% MAIN MATLAB code for main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help main

% Last Modified by GUIDE v2.5 08-Aug-2020 00:16:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @main_OpeningFcn, ...
                   'gui_OutputFcn',  @main_OutputFcn, ...
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


% --- Executes just before main is made visible.
function main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to main (see VARARGIN)

% Choose default command line output for main
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in choose_file.
function choose_file_Callback(hObject, eventdata, handles)
% hObject    handle to choose_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[fname,path]=uigetfile('*.*','Please Select file');
fname=strcat(path,fname);
brain=imread(fname);
hObject.UserData=brain;
subplot(2,2,4);
imshow(brain,'InitialMagnification',200);
caption = sprintf('Choosed Image');
title(caption, 'FontSize', 12, 'Interpreter', 'None');
drawnow;

% --- Executes on button press in brain_b.
function brain_b_Callback(hObject, eventdata, handles)
% hObject    handle to brain_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of brain_b


% --- Executes on button press in lung_b.
function lung_b_Callback(hObject, eventdata, handles)
% hObject    handle to lung_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of lung_b


% --- Executes on button press in breast_b.
function breast_b_Callback(hObject, eventdata, handles)
% hObject    handle to breast_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of breast_b


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_3_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function my_closereq(src,callbackdata)
% Close request function 
% to display a question dialog box 
   selection = questdlg('Close This Figure?',...
      'Close Request Function',...
      'Yes','No','Yes'); 
   switch selection, 
      case 'Yes',
         delete(gcf)
      case 'No'
      return 
   end

% --- Executes on button press in detect_b.
function detect_b_Callback(hObject, eventdata, handles)
% hObject    handle to detect_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

f = findobj('Tag','choose_file');
brain = f.UserData;
scrsz = get(groot,'ScreenSize');
figure('Position',[1 scrsz(4)/2 scrsz(3)/2 scrsz(4)/2],'OuterPosition',[100 150 5*scrsz(3)/6 500],'Name','Analyzed Results','NumberTitle','off','MenuBar','none','ToolBar','figure','CloseRequestFcn',@my_closereq);
subplot(1, 4, 1);
imshow(brain, []);
axis on;
caption = sprintf('Original Image');
title(caption, 'FontSize', 18, 'Interpreter', 'None');
drawnow;


brain=im2bw(brain,graythresh(brain));
hy = fspecial('log');
hx = hy';
Iy = imfilter(double(brain), hy, 'replicate');
Ix = imfilter(double(brain), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
subplot(1,4,2)
imshow(gradmag,[]), title('Gradient magnitude (gradmag)')
subplot(1,4,3)
imshow(imcontour(imread('brain21.jpg')))
[label , num] = bwlabel(gradmag);

status = regionprops(label , 'Solidity' , 'Area');
density = [status.Solidity];
area = [status.Area];


high_dense_area = density > 0.5;

max_area = max(area(high_dense_area));

tumor_label = find(area == max_area);

tumor = ismember(label , tumor_label);

SE = strel('square' , 5);
tumor = imdilate(tumor , SE);

bound = bwboundaries(tumor , 'noholes');

finalPicture1 = edge(tumor);

[r1 , c1] = find(finalPicture1);

x2 = max(r1);
x1 = min(r1);

y2 = max(c1);
y1 = min(c1);

width = x2 - x1;
heigth = y2 - y1;
subplot(1,4,4) , imshow(tumor);
if width > 11
    if(heigth > 11)
        
    end
end