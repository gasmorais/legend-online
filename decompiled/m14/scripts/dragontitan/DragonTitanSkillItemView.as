package dragontitan
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import managers.DragonTitanManager;
   import mvc.module.dragonTitan.DragonTitanInjectInfo;
   import mvc.module.dragonTitan.DragonTitanModel;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.DragManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseIconView;
   
   public class DragonTitanSkillItemView extends Component
   {
      
      private var _data:SkillTempInfo;
      
      private var _titanId:int;
      
      private var _skillBg1:Image;
      
      private var _selectedSkillBg:Image;
      
      private var _equippedCornerMark:Image;
      
      private var _lockSkill:Image;
      
      private var _icon:BaseIconView;
      
      private var _injectContainer:Sprite;
      
      private var _circle:Bitmap;
      
      private var _loack:Bitmap;
      
      private var _numSprite:Sprite;
      
      private var _numBmp:Bitmap;
      
      public function DragonTitanSkillItemView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _skillBg1 = ComponentFactory.Instance.creatComponentByStylename("dragontitan.skillBg1");
         _selectedSkillBg = ComponentFactory.Instance.creatComponentByStylename("dragontitan.selectedSkillBg");
         _equippedCornerMark = ComponentFactory.Instance.creatComponentByStylename("dragontitan.equippedCornerMark");
         _lockSkill = ComponentFactory.Instance.creatComponentByStylename("dragontitan.lockSkill");
         _icon = ComponentFactory.Instance.creatCustomObject("dragontitan.DragonTitanSkillSlot.icon");
         _injectContainer = new Sprite();
         _injectContainer.x = _injectContainer.y = 42;
         _numBmp = ComponentFactory.Instance.creatBitmap("asset.dragontitan.number");
         addChild(_skillBg1);
         addChild(_icon);
         addChild(_selectedSkillBg);
         addChild(_lockSkill);
         addChild(_equippedCornerMark);
         addChild(_injectContainer);
         _selectedSkillBg.visible = false;
         _equippedCornerMark.visible = false;
         _equippedCornerMark.mouseChildren = _equippedCornerMark.mouseEnabled = false;
         _lockSkill.visible = false;
      }
      
      public function setLock() : void
      {
         if(_data)
         {
            return;
         }
         _lockSkill.visible = true;
         _selectedSkillBg.visible = false;
         _icon.visible = false;
      }
      
      public function setUnlock() : void
      {
         _lockSkill.visible = false;
         _icon.visible = true;
      }
      
      public function setEquipped() : void
      {
         _equippedCornerMark.visible = true;
      }
      
      public function setUnequipped() : void
      {
         _equippedCornerMark.visible = false;
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         _data = param1;
         if(_icon)
         {
            _icon.icon = null;
            _icon.tipData = null;
            if(!_data)
            {
               return;
            }
            _icon.icon = IconFactory.getTecIconByIcon(_data.Icons);
            _icon.tipData = _data;
         }
      }
      
      public function get data() : *
      {
         return _data;
      }
      
      private function unInitView() : void
      {
         if(_skillBg1)
         {
            ObjectUtils.disposeObject(_skillBg1);
         }
         _skillBg1 = null;
         if(_selectedSkillBg)
         {
            ObjectUtils.disposeObject(_selectedSkillBg);
         }
         _selectedSkillBg = null;
         if(_equippedCornerMark)
         {
            ObjectUtils.disposeObject(_equippedCornerMark);
         }
         _equippedCornerMark = null;
         if(_lockSkill)
         {
            ObjectUtils.disposeObject(_lockSkill);
         }
         _lockSkill = null;
         if(_icon)
         {
            ObjectUtils.disposeObject(_icon);
         }
         _icon = null;
         if(_injectContainer)
         {
            ObjectUtils.disposeObject(_injectContainer);
         }
         _injectContainer = null;
         if(_circle)
         {
            ObjectUtils.disposeObject(_circle);
         }
         _circle = null;
         if(_loack)
         {
            ObjectUtils.disposeObject(_loack);
         }
         _loack = null;
         if(_numSprite)
         {
            ObjectUtils.disposeObject(_numSprite);
         }
         _numSprite = null;
         if(_numBmp)
         {
            ObjectUtils.disposeObject(_numBmp);
         }
         _numBmp = null;
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseDown",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_icon != null)
         {
            _icon.removeEventListener("mouseDown",__clickHandler);
         }
      }
      
      protected function __clickHandler(param1:MouseEvent) : void
      {
         var _loc2_:DragonTitanInjectInfo = null;
         var _loc5_:DisplayObject = null;
         var _loc4_:GameDrag = null;
         if(!_data)
         {
            return;
         }
         var _loc3_:int = int(DragonTitanManager.instance.model.currentViewIndex);
         if(_loc3_ == 2)
         {
            DragonTitanManager.instance.model.viewTitanId = _titanId;
            MsgMan.notifyObserver("TITAN_FAME_CLICK_SKILL",_titanId);
         }
         else if(_loc3_ == 1)
         {
            _loc2_ = DragonTitanManager.instance.model.getTaitanInjectInfo(_titanId);
            if(!_loc2_.isActive)
            {
               return;
            }
            _loc5_ = getDragIconObj();
            if(!_loc5_)
            {
               return;
            }
            _loc4_ = DragManager.getInstance().starDrag(this,{
               "icon":_loc5_,
               "type":"down"
            });
            _loc4_.onDrop = onDragStop;
            _loc4_.dropChecks = [DragonTitanSkillSlot,Frame,Stage];
         }
      }
      
      private function getDragIconObj() : DisplayObject
      {
         if(_icon.iconWidth == 0)
         {
            return new Bitmap(new BitmapData(30,30,true,285212672));
         }
         var _loc1_:BitmapData = new BitmapData(_icon.iconWidth / _icon.scaleX,_icon.iconHeight / _icon.scaleY,true,0);
         _loc1_.draw(_icon);
         var _loc3_:Bitmap = new Bitmap(_loc1_);
         var _loc2_:Sprite = new Sprite();
         _loc2_.addChild(_loc3_);
         return _loc2_;
      }
      
      private function onDragStop(param1:GameDrag) : void
      {
         var _loc2_:DragonTitanSkillSlot = null;
         var _loc3_:int = 0;
         if(param1.dropTarget != this)
         {
            param1.stopImmediatePropagation();
            if(param1.dropTarget is DragonTitanSkillSlot)
            {
               _loc2_ = param1.dropTarget as DragonTitanSkillSlot;
               _loc3_ = int(model.getTitanIdBySkillId(_data.TemplateId));
               MsgMan.notifyObserver("DragonTitanEvent.TITAN_SET_SKILL",{
                  "titanId":_loc3_,
                  "index":_loc2_.index
               });
               _loc2_.data = _data;
            }
         }
      }
      
      public function setGridState(param1:DragonTitanInjectInfo) : void
      {
         var _loc2_:GlowFilter = null;
         clearInjectIcon();
         this.filters = null;
         if(model.viewTitanId == titanId)
         {
            if(param1 && !param1.isActive)
            {
               _loc2_ = UIFilter.getGlowFilter();
            }
         }
         if(!param1 || Boolean(param1.isActive))
         {
            if(_loc2_)
            {
               this.filters = [_loc2_];
            }
            return;
         }
         this._circle = ComponentFactory.Instance.creatBitmap("asset.dragontitan.cricle");
         _injectContainer.addChild(_circle);
         if(param1.injectGrade == 0)
         {
            _loack = ComponentFactory.Instance.creatBitmap("asset.dragontitan.lock");
            _injectContainer.addChild(_loack);
            _loack.x = _injectContainer.width - _loack.width >> 1;
            _loack.y = _injectContainer.height - _loack.height >> 1;
         }
         else
         {
            _numSprite = new Sprite();
            NumberViewUtils.refreshValue(param1.injectGrade,_numSprite,_numBmp.bitmapData,16,20,15,16,"1234567890");
            _injectContainer.addChild(_numSprite);
            _numSprite.x = _injectContainer.width - _numSprite.width >> 1;
            _numSprite.y = _injectContainer.height - _numSprite.height >> 1;
         }
         this.filters = _loc2_ ? [UIFilter.getGrayFilter(),_loc2_] : [UIFilter.getGrayFilter()];
         _injectContainer.mouseChildren = _injectContainer.mouseEnabled = false;
      }
      
      private function clearInjectIcon() : void
      {
         if(_numSprite)
         {
            _numSprite.parent.removeChild(_numSprite);
            _numSprite = null;
         }
         disposeBmp(_circle);
         disposeBmp(_loack);
      }
      
      private function disposeBmp(param1:Bitmap) : void
      {
         if(param1)
         {
            if(param1.parent)
            {
               param1.parent.removeChild(param1);
            }
            param1.bitmapData.dispose();
            param1 = null;
         }
      }
      
      private function get model() : DragonTitanModel
      {
         return DragonTitanManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         disposeBmp(_numBmp);
         super.dispose();
      }
      
      public function get titanId() : int
      {
         return _titanId;
      }
      
      public function set titanId(param1:int) : void
      {
         _titanId = param1;
      }
   }
}

