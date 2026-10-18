package ui.resourcebar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.PetSocketOut;
   import mvc.module.pet.PetData;
   import mvc.module.pet.pethallows.PetHallowsModel;
   import ui.resourcebar.ResourcesBar;
   import yishi.manager.PetHallowsManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class PetSortItem extends Component
   {
      
      private var _icon:BaseIconView;
      
      private var _overbg:DisplayObject;
      
      private var _nameTxt:FilterFrameText;
      
      private var _gradeTxt:FilterFrameText;
      
      private var _data:PetData;
      
      private var _flag:int;
      
      private var _strip:StripView;
      
      private var _stateFlag:ScaleFrameImage;
      
      private var _hallowsFlag:Bitmap;
      
      public var itemClickHandler:Function;
      
      public function PetSortItem(param1:int)
      {
         super();
         _flag = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _overbg = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.ItemOver");
         _icon = ComponentFactory.Instance.creatCustomObject("resoueceBar.PetIcon");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.PetItemName");
         _gradeTxt = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.PetItemGrade");
         _strip = ComponentFactory.Instance.creatCustomObject("resourceBar.PetIconStrip");
         _stateFlag = ComponentFactory.Instance.creatComponentByStylename("resourceBar.StateFlag");
         _hallowsFlag = ComponentFactory.Instance.creatBitmap("asset.PetSortItem.hallowsFlag");
         addChild(_overbg);
         addChild(_icon);
         addChild(_nameTxt);
         addChild(_gradeTxt);
         addChild(_stateFlag);
         addChild(_hallowsFlag);
         _stateFlag.scaleX = 0.5;
         _stateFlag.scaleY = 0.5;
         _strip.setHitArea(0,3,160,32);
         _strip.tipGapH = -5;
         addChild(_strip);
         _overbg.visible = false;
         _hallowsFlag.visible = false;
      }
      
      private function addEvent() : void
      {
         this.addEventListener("rollOver",mouseOverHandler);
         this.addEventListener("rollOut",mouseOutHandler);
         this.addEventListener("click",mouseClickHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("rollOver",mouseOverHandler);
         this.removeEventListener("rollOut",mouseOutHandler);
         this.removeEventListener("click",mouseClickHandler);
      }
      
      private function mouseOverHandler(param1:MouseEvent) : void
      {
         _overbg.visible = true;
      }
      
      private function mouseOutHandler(param1:MouseEvent) : void
      {
         _overbg.visible = false;
      }
      
      private function mouseClickHandler(param1:MouseEvent) : void
      {
         if(itemClickHandler != null)
         {
            itemClickHandler(data.petId);
            LayerManager.Instance.clearGameMenuLayer();
            return;
         }
         if(!data.isBind)
         {
            ResourcesBar.instance.checkPetBind(data,_flag);
            LayerManager.Instance.clearGameMenuLayer();
            return;
         }
         if(_flag == 1)
         {
            PetSocketOut.enterWar(data.petId);
         }
         else if(_flag == 2)
         {
            PetSocketOut.enterChildPet(data.petId,1);
         }
         else if(_flag == 3)
         {
            PetSocketOut.enterChildPet(data.petId,2);
         }
         else if(_flag == 4)
         {
            PetHallowsManager.instance.sendPetHallowsRequest(3,hallowsModel.selectedHallowsTemp.HallowType,data.petId);
         }
         LayerManager.Instance.clearGameMenuLayer();
      }
      
      public function get data() : PetData
      {
         return _data;
      }
      
      public function set data(param1:PetData) : void
      {
         _data = param1;
         if(!_data)
         {
            return;
         }
         refresh();
      }
      
      private function refresh() : void
      {
         var _loc1_:String = null;
         if(data.templateId != 0)
         {
            _loc1_ = IconFactory.getPetHeadSmallIcon(data.templateId);
         }
         if(_icon.icon != _loc1_)
         {
            _icon.icon = _loc1_;
         }
         _nameTxt.text = data.name;
         _nameTxt.setFrame(_data.quality);
         _gradeTxt.text = LanguageMgr.GetTranslation("public.level2",data.grade);
         if(_nameTxt.numLines > 1)
         {
            _nameTxt.y = 0;
            _nameTxt.height = 35;
         }
         else
         {
            _nameTxt.y = 10;
            _nameTxt.height = 22;
         }
         if(_data.isEnterWar)
         {
            _stateFlag.setFrame(2);
         }
         else if(_data.isChildWar != 0)
         {
            _stateFlag.setFrame(3);
         }
         else
         {
            _stateFlag.setFrame(1);
         }
         if(_flag == 4 && hallowsModel.getPetHasEquipHallows(_data.petId))
         {
            _hallowsFlag.visible = true;
         }
         else
         {
            _hallowsFlag.visible = false;
         }
         _strip.tipData = _data;
      }
      
      private function get hallowsModel() : PetHallowsModel
      {
         return PetHallowsManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_overbg);
         _overbg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_gradeTxt);
         _gradeTxt = null;
         ObjectUtils.disposeObject(_strip);
         _strip = null;
         ObjectUtils.disposeObject(_stateFlag);
         _stateFlag = null;
         ObjectUtils.disposeObject(_hallowsFlag);
         _hallowsFlag = null;
         _data = null;
         itemClickHandler = null;
         super.dispose();
      }
   }
}

