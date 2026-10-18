package armyII.viewII.rune
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import events.RuneEvent;
   import events.SkillEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.module.armyII.RuneInfo;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class FastRuneItem extends Sprite implements Disposeable
   {
      
      public var isUsed:Boolean;
      
      private var _isLock:Boolean = false;
      
      private var _equipedBack:Image;
      
      private var _equipedLock:Bitmap;
      
      private var _equipedIcon:BaseIconView;
      
      private var _effectBack:Bitmap;
      
      private var _data:RuneInfo;
      
      private var _equipedTip:StripView;
      
      public function FastRuneItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _equipedBack = ComponentFactory.Instance.creatComponentByStylename("army.rune.IconBack");
         _equipedLock = ComponentFactory.Instance.creatBitmap("asset.army.rune.ItemLockAsset");
         _equipedIcon = ComponentFactory.Instance.creatCustomObject("army.rune.EquipedIcon");
         _effectBack = ComponentFactory.Instance.creatBitmap("asset.army.rune.RuneItemSelectedBg2");
         _equipedTip = ComponentFactory.Instance.creatCustomObject("army.rune.EquipedTip");
         addChild(_equipedBack);
         addChild(_equipedLock);
         addChild(_equipedIcon);
         addChild(_effectBack);
         addChild(_equipedTip);
         _effectBack.width = 85;
         _effectBack.visible = false;
         _equipedTip.addChild(createShape());
         _equipedTip.tipData = LanguageMgr.GetTranslation("armyII.viewII.rune.FastRuneItem.OpenTipTxt2");
      }
      
      private function createShape(param1:int = 65) : Shape
      {
         var _loc2_:Shape = new Shape();
         _loc2_.graphics.beginFill(16711680,0);
         _loc2_.graphics.drawRect(0,0,param1,param1);
         _loc2_.graphics.endFill();
         return _loc2_;
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
         if(_equipedIcon)
         {
            _equipedIcon.addEventListener("mouseDown",__downHandler);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
         removeEventListener("click",__clickHandler);
         if(_equipedIcon != null)
         {
            _equipedIcon.removeEventListener("mouseDown",__downHandler);
         }
         if(_data != null)
         {
            _data.removeEventListener("RUNE_UPGRADE",__upgradeHandler);
         }
      }
      
      public function setBySkillView(param1:Boolean = false) : void
      {
         _equipedIcon.removeEventListener("mouseDown",__downHandler);
         if(!param1)
         {
            addEventListener("click",__clickHandler);
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new SkillEvent("OPEN_RUNE_VIEW",null,true));
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         _effectBack.visible = true;
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _effectBack.visible = false;
      }
      
      private function __downHandler(param1:MouseEvent) : void
      {
         var _loc3_:DisplayObject = getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(this,{
            "icon":_loc3_,
            "type":"down"
         });
         _loc2_.onDrop = onDragStop;
         _loc2_.dropChecks = [FastRuneItem,Frame,Stage];
      }
      
      private function onDragStop(param1:GameDrag) : void
      {
         var _loc2_:FastRuneItem = null;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is FastRuneItem)
            {
               _loc2_ = param1.dropTarget as FastRuneItem;
               if(!_loc2_.isLock)
               {
                  swap(this,_loc2_);
                  param1.stopImmediatePropagation();
                  NotificationManager.instance.sendNotification("SET_FAST_KEY",null);
               }
               else
               {
                  param1.stopImmediatePropagation();
               }
            }
            else
            {
               data = null;
               refreshView();
               NotificationManager.instance.sendNotification("SET_FAST_KEY",null);
               param1.stopImmediatePropagation();
            }
         }
      }
      
      private function swap(param1:FastRuneItem, param2:FastRuneItem) : void
      {
         var _loc3_:RuneInfo = param2.data;
         param2.data = param1.data;
         param2.refreshView();
         param1.data = _loc3_;
         param1.refreshView();
      }
      
      private function getDragIconObj() : DisplayObject
      {
         if(_equipedIcon.iconWidth == 0)
         {
            return new Bitmap(new BitmapData(30,30,true,285212672));
         }
         var _loc1_:BitmapData = new BitmapData(_equipedIcon.iconWidth / _equipedIcon.scaleX,_equipedIcon.iconHeight / _equipedIcon.scaleY,true,0);
         _loc1_.draw(_equipedIcon);
         var _loc3_:Bitmap = new Bitmap(_loc1_);
         var _loc2_:Sprite = new Sprite();
         _loc2_.addChild(_loc3_);
         return _loc2_;
      }
      
      public function set data(param1:RuneInfo) : void
      {
         if(_data)
         {
            _data.removeEventListener("RUNE_UPGRADE",__upgradeHandler);
         }
         _data = param1;
         if(_data)
         {
            _data.addEventListener("RUNE_UPGRADE",__upgradeHandler);
         }
         else
         {
            isUsed = false;
         }
      }
      
      public function get data() : RuneInfo
      {
         return _data;
      }
      
      private function __upgradeHandler(param1:RuneEvent) : void
      {
         if(_data)
         {
            refreshView();
            NotificationManager.instance.sendNotification("SET_FAST_KEY",null);
         }
      }
      
      public function refreshView() : void
      {
         var _loc1_:String = null;
         if(!_equipedIcon)
         {
            return;
         }
         if(_data)
         {
            _equipedIcon.tipData = _data.templateInfo;
            _loc1_ = IconFactory.getTecIconByIcon(_data.templateInfo.Icon);
            if(_equipedIcon.icon != _loc1_)
            {
               _equipedIcon.icon = _loc1_;
            }
         }
         else
         {
            _equipedIcon.tipData = null;
            _equipedIcon.icon = null;
         }
      }
      
      public function get isLock() : Boolean
      {
         return _isLock;
      }
      
      public function set isLock(param1:Boolean) : void
      {
         _isLock = param1;
         _equipedLock.visible = _isLock;
         _equipedTip.visible = _isLock;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_equipedBack);
         _equipedBack = null;
         ObjectUtils.disposeObject(_equipedLock);
         _equipedLock = null;
         ObjectUtils.disposeObject(_equipedIcon);
         _equipedIcon = null;
         ObjectUtils.disposeObject(_effectBack);
         _effectBack = null;
         ObjectUtils.disposeAllChildren(_equipedTip);
         ObjectUtils.disposeObject(_equipedTip);
         _equipedTip = null;
         ObjectUtils.disposeAllChildren(this);
         _data = null;
      }
   }
}

