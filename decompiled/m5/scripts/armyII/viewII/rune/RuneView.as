package armyII.viewII.rune
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.RuneInfo;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.RuneTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.view.component.TileContainer;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class RuneView extends Sprite implements Disposeable
   {
      
      private var _equiped:Bitmap;
      
      private var _tips:Bitmap;
      
      private var _back1:MovieClip;
      
      private var _back2:MovieClip;
      
      private var _contain:TileContainer;
      
      private var _runeList:Array;
      
      private var _runeKeyList:Array;
      
      private var _helpBtn:BaseButton;
      
      private var _icon:Sprite;
      
      public function RuneView()
      {
         super();
         initView();
         initRuneList();
         refreshRune();
         initRuneKeyList();
         initEvent();
      }
      
      private function initView() : void
      {
         _back1 = ComponentFactory.Instance.creatCustomObject("army.rune.Back1");
         _back2 = ComponentFactory.Instance.creatCustomObject("army.rune.Back2");
         _equiped = ComponentFactory.Instance.creatBitmap("asset.army.rune.EquipAsset");
         _tips = ComponentFactory.Instance.creatBitmap("asset.army.rune.TipsTxt");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("army.stone.rune.HelpBtn");
         _contain = new TileContainer();
         _contain.width = 700;
         _contain.paddingH = 18;
         _contain.paddingV = 0;
         _contain.rowCount = 2;
         _contain.columnCount = 5;
         _contain.x = 75;
         _contain.y = 20;
         addChild(_back1);
         addChild(_back2);
         addChild(_equiped);
         addChild(_tips);
         addChild(_contain);
         if(VersionSwitch.RUNE_STONE)
         {
            addChild(_helpBtn);
         }
         _runeList = [];
         _runeKeyList = [];
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("RUNE_UPGRADE",__runeRefreshHandler);
         NotificationManager.instance.addEventListener("SET_FAST_KEY",__setFastKeyHandler);
         NotificationManager.instance.addEventListener("FAST_KEY_MOVE",__fastKeyMoveHandler);
         _helpBtn.addEventListener("click",__helpClick);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("RUNE_UPGRADE",__runeRefreshHandler);
         NotificationManager.instance.removeEventListener("SET_FAST_KEY",__setFastKeyHandler);
         NotificationManager.instance.removeEventListener("FAST_KEY_MOVE",__fastKeyMoveHandler);
         _helpBtn.removeEventListener("click",__helpClick);
      }
      
      private function __helpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("army.stone.rune.helperFrame");
         _loc2_.show();
      }
      
      private function __fastKeyMoveHandler(param1:NotificationEvent) : void
      {
         var _loc5_:RuneInfo = param1.data["data"];
         var _loc4_:Point = param1.data["point"];
         _icon = param1.data["icon"];
         var _loc2_:FastRuneItem = getEmputyItem();
         if(!_loc2_)
         {
            return;
         }
         _loc2_.data = _loc5_;
         __setFastKeyHandler();
         _icon.x = _loc4_.x;
         _icon.y = _loc4_.y;
         stage.addChild(_icon);
         var _loc3_:Point = _loc2_.parent.localToGlobal(new Point(_loc2_.x,_loc2_.y));
         TweenMax.to(_icon,1,{
            "x":_loc3_.x,
            "y":_loc3_.y,
            "onComplete":_moveComplete,
            "onCompleteParams":[_loc2_,_loc5_,_icon]
         });
      }
      
      private function _moveComplete(param1:FastRuneItem, param2:RuneInfo, param3:Sprite) : void
      {
         param3 && TweenMax.killTweensOf(param3);
         if(param1)
         {
            param1.refreshView();
         }
         ObjectUtils.disposeObject(param3);
      }
      
      private function __runeRefreshHandler(param1:NotificationEvent) : void
      {
         refreshRune();
      }
      
      private function __setFastKeyHandler(param1:NotificationEvent = null) : void
      {
         control.sendTakeRune(fastKey);
      }
      
      private function initRuneList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RuneItemView = null;
         var _loc3_:Array = thane.runeCate.allRuneList.getList();
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc1_ = new RuneItemView();
            _contain.appendItem(_loc1_);
            _runeList[_loc2_] = _loc1_;
            _loc2_++;
         }
      }
      
      private function initRuneKeyList() : void
      {
         var _loc4_:int = 0;
         var _loc2_:FastRuneItem = null;
         var _loc1_:Boolean = false;
         var _loc5_:int = 0;
         var _loc3_:RuneTemplateInfo = null;
         var _loc7_:RuneInfo = null;
         var _loc6_:Array = thane.runeCate.runeScript.split(",");
         _loc5_ = 0;
         while(_loc5_ < 2)
         {
            _loc2_ = new FastRuneItem();
            addChild(_loc2_);
            _loc2_.x = 160 + _loc5_ * 85;
            _loc2_.y = 313;
            _loc1_ = thane.grades < 35 + _loc5_ * 5;
            _loc2_.isLock = _loc1_;
            if(!_loc2_.isLock && _loc5_ < _loc6_.length)
            {
               _loc3_ = TempleteManager.instance.getRuneTemplateByTid(_loc6_[_loc5_]);
               if(_loc3_)
               {
                  _loc7_ = thane.runeCate.getInfoByIndex(_loc3_.RuneIndex);
                  _loc2_.data = _loc7_;
                  _loc2_.refreshView();
               }
            }
            else
            {
               _loc2_.data = null;
            }
            _runeKeyList.push(_loc2_);
            _loc5_++;
         }
      }
      
      private function sortRune(param1:RuneInfo, param2:RuneInfo) : int
      {
         if(param1.templateInfo.RuneIndex < param2.templateInfo.RuneIndex)
         {
            return -1;
         }
         if(param1.templateInfo.RuneIndex > param2.templateInfo.RuneIndex)
         {
            return 1;
         }
         return 0;
      }
      
      private function refreshRune() : void
      {
         var _loc2_:int = 0;
         var _loc5_:RuneInfo = null;
         var _loc1_:RuneItemView = null;
         var _loc4_:Array = thane.runeCate.allRuneList.getList();
         _loc4_.sort(sortRune);
         for(var _loc3_:String in _runeList)
         {
            _loc2_ = int(_loc3_);
            _loc5_ = _loc4_[_loc2_];
            _loc1_ = _runeList[_loc3_] as RuneItemView;
            if(_loc5_)
            {
               _loc1_.data = _loc5_;
            }
            else
            {
               _loc1_.data = null;
            }
         }
      }
      
      public function get fastKey() : String
      {
         var _loc4_:int = 0;
         var _loc2_:FastRuneItem = null;
         var _loc1_:String = "";
         var _loc3_:int = int(_runeKeyList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _runeKeyList[_loc4_] as FastRuneItem;
            if(_loc2_.data)
            {
               _loc1_ += _loc2_.data.runeId + ",";
            }
            else
            {
               _loc1_ += "-1,";
            }
            _loc4_++;
         }
         return _loc1_;
      }
      
      public function getEmputyItem() : FastRuneItem
      {
         var _loc3_:int = 0;
         var _loc1_:FastRuneItem = null;
         var _loc2_:int = int(_runeKeyList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _runeKeyList[_loc3_] as FastRuneItem;
            if(!_loc1_.data && !_loc1_.isUsed && !_loc1_.isLock)
            {
               _loc1_.isUsed = true;
               return _loc1_;
            }
            _loc3_++;
         }
         return null;
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         var _loc1_:Disposeable = null;
         removeEvent();
         if(_icon)
         {
            TweenMax.killTweensOf(_icon);
            ObjectUtils.disposeAllChildren(_icon);
            _icon.parent && _icon.parent.removeChild(_icon);
            _icon = null;
         }
         ObjectUtils.disposeObject(_back1);
         ObjectUtils.disposeObject(_back2);
         ObjectUtils.disposeObject(_equiped);
         ObjectUtils.disposeObject(_tips);
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_contain);
         for each(_loc1_ in _runeKeyList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         for each(_loc1_ in _runeList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _runeKeyList = null;
         _runeList = null;
         _contain = null;
         _back1 = null;
         _back2 = null;
         _equiped = null;
         _tips = null;
      }
   }
}

