package simplegame.qte
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.KeyboardEvent;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   import utils.LogicUtils;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   
   public class QTEComponent extends Sprite
   {
      
      private static const QTE_NUM:int = 3;
      
      private var _hBox:HBox;
      
      private var _list:Vector.<QteItem>;
      
      private var _keyCode:String = "ASDW";
      
      private var _isRight:Boolean;
      
      private var _showEff:MovieClip;
      
      private var _timeId1:int;
      
      private var _successEff:MovieClip;
      
      private var _filter:IFilterFormat;
      
      private var _qteNum:int;
      
      private var _callback:Function;
      
      public function QTEComponent(param1:int, param2:Function)
      {
         super();
         _qteNum = param1;
         _callback = param2;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _filter = new UIFilter();
         _showEff = ClassUtils.CreatInstance("asset.qte.QTEShowEf");
         _successEff = ClassUtils.CreatInstance("asset.qte.QTESuccess");
         _successEff.y = 55;
         _showEff.gotoAndStop(1);
         _successEff.gotoAndStop(1);
         mouseChildren = mouseEnabled = false;
         addQte();
         addChild(_showEff);
         addChild(_successEff);
         _successEff.x = _hBox.x + _hBox.width / 2;
         if(_timeId1 > 0)
         {
            clearInterval(_timeId1);
         }
         _timeId1 = 0;
         _timeId1 = setTimeout(showShowEff,200);
      }
      
      private function addQte() : void
      {
         var _loc2_:int = 0;
         var _loc1_:QteItem = null;
         _hBox = new HBox();
         _hBox.spacing = 2;
         _hBox.x = 47;
         _hBox.y = -4;
         _list = new Vector.<QteItem>();
         addChild(_hBox);
         _loc2_ = 0;
         while(_loc2_ < _qteNum)
         {
            _loc1_ = new QteItem();
            _loc1_.data = _keyCode.charAt(Math.floor(Math.random() * 4));
            _hBox.addChild(_loc1_);
            _list.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function showShowEff() : void
      {
         _showEff.scaleX = _qteNum / 3;
         _showEff.play();
      }
      
      private function addEvent() : void
      {
         StageReferance.stage.addEventListener("keyDown",__onKeyDownHandler,false,200);
      }
      
      private function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("keyDown",__onKeyDownHandler);
      }
      
      private function __onKeyDownHandler(param1:KeyboardEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:int = 0;
         if(param1.keyCode == 37)
         {
            _loc3_ = "A";
         }
         else if(param1.keyCode == 38)
         {
            _loc3_ = "W";
         }
         else if(param1.keyCode == 39)
         {
            _loc3_ = "D";
         }
         else if(param1.keyCode == 40)
         {
            _loc3_ = "S";
         }
         else
         {
            _loc3_ = String.fromCharCode(param1.keyCode);
         }
         _isRight = true;
         _loc2_ = 0;
         while(_loc2_ < _list.length)
         {
            if(!_list[_loc2_].isRight)
            {
               _list[_loc2_].isRight = _loc3_ == _list[_loc2_].data ? true : false;
               if(!_list[_loc2_].isRight)
               {
                  _isRight = false;
                  reset();
               }
               if(_loc2_ < _list.length - 1)
               {
                  _isRight = false;
               }
               break;
            }
            _loc2_++;
         }
         if(_isRight)
         {
            _callback();
         }
      }
      
      public function setEffect(param1:Boolean) : void
      {
         removeEvent();
         if(param1)
         {
            _successEff.gotoAndPlay(1);
         }
         else
         {
            _filter.setGrayFilter(this);
         }
         for each(var _loc2_:QteItem in _list)
         {
            _loc2_.tweenEffect(param1);
         }
      }
      
      public function reset() : void
      {
         for each(var _loc1_:QteItem in _list)
         {
            _loc1_.isRight = false;
         }
      }
      
      public function set enable(param1:Boolean) : void
      {
         if(param1)
         {
            addEvent();
         }
         else
         {
            removeEvent();
         }
      }
      
      override public function get width() : Number
      {
         if(_hBox && _list && _list.length > 0)
         {
            return _hBox.x + (_list[0].width + 2) * _list.length;
         }
         return super.width;
      }
      
      public function getCenterPosX() : int
      {
         return _successEff.x;
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_timeId1 > 0)
         {
            clearInterval(_timeId1);
         }
         _timeId1 = 0;
         if(_successEff)
         {
            ObjectUtils.disposeViolentMc(_successEff);
         }
         _successEff = null;
         if(_showEff)
         {
            ObjectUtils.disposeViolentMc(_showEff);
         }
         _showEff = null;
         if(_hBox)
         {
            ObjectUtils.disposeObject(_hBox);
         }
         _hBox = null;
         LogicUtils.disposeDisplayCollection(_list);
         _list = null;
         _filter = null;
         _callback = null;
      }
   }
}

