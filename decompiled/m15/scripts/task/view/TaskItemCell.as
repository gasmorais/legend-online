package task.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.cell.IListCell;
   import com.pickgliss.ui.controls.list.List;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mvc.module.marry.MarryTask;
   import mvc.module.offerreward.BaseOfferReward;
   import mvc.module.ringtask.RingTask;
   import mvc.module.task.TaskCondictionTemplate;
   import mvc.module.task.TaskTemplate;
   import yishi.utils.MsgMan;
   
   public class TaskItemCell extends Component implements IListCell, ISelectable
   {
      
      public static const P_backStyle:String = "backStyle";
      
      public static const P_iconStyle:String = "iconStyle";
      
      public static const P_textStyle:String = "textStyle";
      
      public static const P_selectStyle:String = "selectStyle";
      
      private var _backStyle:String;
      
      private var _iconStyle:String;
      
      private var _textStyle:String;
      
      private var _selectStyle:String;
      
      private var _back:ScaleFrameImage;
      
      private var _icon:ScaleFrameImage;
      
      private var _text:FilterFrameText;
      
      private var _data:Object;
      
      private var _completeStr:String;
      
      private var _selectEffect:Bitmap;
      
      private var _haloMC:MovieClip;
      
      private var _selected:Boolean;
      
      private var _isComplete:Boolean;
      
      public function TaskItemCell()
      {
         super();
         buttonMode = true;
         initEvent();
      }
      
      public function get backStyle() : String
      {
         return _backStyle;
      }
      
      public function set backStyle(param1:String) : void
      {
         if(_backStyle == param1)
         {
            return;
         }
         _backStyle = param1;
         onPropertiesChanged("backStyle");
      }
      
      public function get iconStyle() : String
      {
         return _iconStyle;
      }
      
      public function set iconStyle(param1:String) : void
      {
         if(_iconStyle == param1)
         {
            return;
         }
         _iconStyle = param1;
         onPropertiesChanged("iconStyle");
      }
      
      public function get textStyle() : String
      {
         return _textStyle;
      }
      
      public function set textStyle(param1:String) : void
      {
         if(_textStyle == param1)
         {
            return;
         }
         _textStyle = param1;
         onPropertiesChanged("textStyle");
      }
      
      public function get selectStyle() : String
      {
         return _selectStyle;
      }
      
      public function set selectStyle(param1:String) : void
      {
         if(_selectStyle == param1)
         {
            return;
         }
         _selectStyle = param1;
         onPropertiesChanged("selectStyle");
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_back)
         {
            addChild(_back);
         }
         if(_text)
         {
            addChild(_text);
         }
         if(_selectEffect)
         {
            addChild(_selectEffect);
         }
         if(_icon)
         {
            addChild(_icon);
         }
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["backStyle"])
         {
            _back = ComponentFactory.Instance.creatComponentByStylename(_backStyle);
         }
         if(_changedPropeties["iconStyle"])
         {
            _icon = ComponentFactory.Instance.creatComponentByStylename(_iconStyle);
            _icon.visible = false;
         }
         if(_changedPropeties["textStyle"])
         {
            _text = ComponentFactory.Instance.creatComponentByStylename(_textStyle);
         }
         if(_changedPropeties["selectStyle"])
         {
            _selectEffect = ComponentFactory.Instance.creatBitmap(_selectStyle);
         }
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         setFrame();
         setTextFrame();
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function setFrame() : void
      {
         if(_selected)
         {
            if(_back)
            {
               if(_isComplete)
               {
                  _back.setFrame(3);
               }
               else
               {
                  _back.setFrame(2);
               }
            }
            if(_selectEffect)
            {
               _selectEffect.visible = true;
            }
         }
         else
         {
            if(_back)
            {
               if(_isComplete)
               {
                  _back.setFrame(3);
               }
               else
               {
                  _back.setFrame(1);
               }
            }
            if(_selectEffect)
            {
               _selectEffect.visible = false;
            }
         }
      }
      
      public function setTextFrame() : void
      {
         if(_text)
         {
            if(_data && _data is BaseOfferReward)
            {
               _text.setFrame(_data.profile);
            }
            else
            {
               _text.setFrame(_isComplete ? 7 : 6);
            }
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(!_selected)
         {
            _selectEffect.visible = true;
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         if(!_selected)
         {
            _selectEffect.visible = false;
         }
      }
      
      public function setListCellStatus(param1:List, param2:Boolean, param3:int) : void
      {
         selected = param2;
         if(selected)
         {
            if(_data)
            {
               _data["isNew"] = false;
            }
            refreshView();
         }
      }
      
      public function getCellValue() : *
      {
         return _data;
      }
      
      public function setCellValue(param1:*) : void
      {
         if(!param1)
         {
            return;
         }
         if(_data)
         {
            if(_data is MarryTask)
            {
               MsgMan.removeObserver("MarryEventType.TASK_UPDATE",this,__marryTaskUpdateHandler);
            }
            else
            {
               _data.removeEventListener("task_detail_change",__taskChangeHandler);
               _data.removeEventListener("REWARD_TASK_UPDATE",__taskChangeHandler);
            }
         }
         _data = param1;
         if(_data)
         {
            if(_data is MarryTask)
            {
               MsgMan.addObserver("MarryEventType.TASK_UPDATE",this,__marryTaskUpdateHandler);
            }
            else
            {
               _data.addEventListener("task_detail_change",__taskChangeHandler);
               _data.addEventListener("REWARD_TASK_UPDATE",__taskChangeHandler);
            }
         }
         refreshView();
      }
      
      private function __marryTaskUpdateHandler(param1:String, param2:Object) : void
      {
         __taskChangeHandler(null);
      }
      
      private function __taskChangeHandler(param1:Event) : void
      {
         if(_data is BaseOfferReward)
         {
            if(_data.isCompleted)
            {
               refreshView();
            }
            else
            {
               refreshView();
            }
         }
      }
      
      private function refreshView() : void
      {
         if(_haloMC)
         {
            _haloMC.parent.removeChild(_haloMC);
            _haloMC.stop();
            _haloMC = null;
         }
         if(!_data)
         {
            return;
         }
         if(_data is BaseOfferReward)
         {
            _isComplete = _data.isCompleted;
         }
         else if(_data is RingTask)
         {
            _isComplete = _data.isCompleted;
         }
         else if(_data is MarryTask)
         {
            _isComplete = _data.isCompleted;
         }
         else
         {
            _isComplete = _data.taskInfo && _data.isCompleted && _data.taskInfo.isSelect;
         }
         if(_data is TaskTemplate)
         {
            for each(var _loc1_:TaskCondictionTemplate in _data.conditionList)
            {
               if(_loc1_.CondictionType == 48)
               {
                  if(!_haloMC)
                  {
                     _haloMC = MovieClip(ComponentFactory.Instance.creat("asset.task.TaskPhoneHalo"));
                     addChild(_haloMC);
                  }
               }
            }
         }
         if(_icon)
         {
            _icon.visible = false;
            _icon.x = 176;
            _icon.y = 0;
            if(_isComplete)
            {
               _icon.visible = true;
               _icon.setFrame(1);
               _icon.y = -3;
            }
            else if(_data["isNew"])
            {
               _icon.visible = true;
               _icon.setFrame(2);
               _icon.y = -3;
            }
            else if(_data is TaskTemplate)
            {
               for each(var _loc2_:TaskCondictionTemplate in _data.conditionList)
               {
                  if(_loc2_.CondictionType == 48)
                  {
                     _icon.visible = true;
                     _icon.setFrame(3);
                     _icon.x = 210;
                     _icon.y = -3;
                  }
               }
            }
         }
         if(_text)
         {
            _text.htmlText = _data.Title;
            _text.text = _text.text;
            if(_isComplete)
            {
               _text.y = 7;
            }
            else
            {
               _text.y = 8;
            }
         }
         setFrame();
         setTextFrame();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_text);
         _text = null;
         ObjectUtils.disposeObject(_selectEffect);
         _selectEffect = null;
         if(_data)
         {
            if(_data is MarryTask)
            {
               MsgMan.removeObserver("MarryEventType.TASK_UPDATE",this,__marryTaskUpdateHandler);
            }
            else
            {
               _data.removeEventListener("task_detail_change",__taskChangeHandler);
               _data.removeEventListener("REWARD_TASK_UPDATE",__taskChangeHandler);
            }
            _data = null;
         }
         super.dispose();
      }
   }
}

