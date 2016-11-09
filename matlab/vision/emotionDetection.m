function varargout = emotionDetection(varargin)
% EMOTIONDETECTION MATLAB code for emotionDetection.fig
%      EMOTIONDETECTION, by itself, creates a new EMOTIONDETECTION or raises the existing
%      singleton*.
%
%      H = EMOTIONDETECTION returns the handle to a new EMOTIONDETECTION or the handle to
%      the existing singleton*.
%
%      EMOTIONDETECTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EMOTIONDETECTION.M with the given input arguments.
%
%      EMOTIONDETECTION('Property','Value',...) creates a new EMOTIONDETECTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before emotionDetection_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to emotionDetection_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help emotionDetection

% Last Modified by GUIDE v2.5 02-Nov-2014 03:58:55

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @emotionDetection_OpeningFcn, ...
                   'gui_OutputFcn',  @emotionDetection_OutputFcn, ...
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

global vid;


% --- Executes just before emotionDetection is made visible.
function emotionDetection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to emotionDetection (see VARARGIN)

% Choose default command line output for emotionDetection
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes emotionDetection wait for user response (see UIRESUME)
% uiwait(handles.figure1);

global vid;

imaqInfo = imaqhwinfo;

winvideoinfo = imaqhwinfo('winvideo'); %查询winvideo的具体参数
winvideoinfo.DeviceInfo %视频采集可选择的格式

vid=videoinput('winvideo',1,'YUY2_320x240');%语法：vid=videoinput（adaptorname，deviceID，format）
set(vid,'TriggerRepeat',Inf);%TriggerRepeat重复触发
set(vid,'FramesPerTrigger',1);%FramesPerTrigger每特定的帧数去触发捕获选定使用的视频源
set(vid,'FrameGrabInterval',1);%FrameGrabInterval帧的抓取时间间隔
%设置返回色彩 rgb正常颜色（YUY2格式颜色发红），grayscale是灰度
%set(vid,'ReturnedColorSpace','rgb');
set(vid,'ReturnedColorSpace','grayscale');
%获取分辨率，色彩数目等参数
vidRes=get(vid,'VideoResolution');%视频分辨率
nBands=get(vid,'NumberOfBands');%色彩数目

hImage=image(zeros(vidRes(2),vidRes(1),nBands));

% himage：视频预览窗口对应的句柄，也就是说在指定的句柄对象中预览视频，该参数可以空缺。至于预览窗口的关闭和停止可以使用colsepreview和stoppreview函数

preview(vid,hImage);

axes(handles.axes1);

guidata(hObject, handles);


% --- Outputs from this function are returned to the command line.
function varargout = emotionDetection_OutputFcn(hObject, eventdata, handles) 
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

%guidata(hObject,handles);
global vid;

count = 1;
while(1)
    frame = getsnapshot(vid);
    vec = reshape(frame,1,320*240);
    if count == 1
        imstream = vec;
    else
        imstream = [imstream;vec];
    end
    count = count + 1;
    if count > 30;
        break;
    end
end

save('imstream.mat','imstream');

%after the video capture,notification!
set(handles.text2,'String','image done!');
guidata(hObject,handles);

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

state = run(imstream);
set(handles.text2,'String',state);
guidata(hObject,handles);
