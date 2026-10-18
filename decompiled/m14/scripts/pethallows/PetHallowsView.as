package pethallows
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import mvc.module.pet.PetData;
   import mvc.module.pet.pethallows.PetHallowsInfo;
   import mvc.module.pet.pethallows.PetHallowsModel;
   import ui.resourcebar.view.PetSortList;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.PetTemplate;
   import yishi.manager.PetHallowsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class PetHallowsView extends Component
   {
      
      private var back:MutipleImage;
      
      private var petBack:Image;
      
      private var petIcon:BaseIconView;
      
      private var petStrip:StripView;
      
      private var restBtn:BaseButton;
      
      private var canEquipText:FilterFrameText;
      
      private var alertText:FilterFrameText;
      
      private var rightView:PetHallowsRightSkillView;
      
      private var hallowsMcView:PetHallowsMcView;
      
      private var noActiveImage:MutipleImage;
      
      private var petSprite:Sprite;
      
      private var selectPetBtn:BaseButton;
      
      private var _petList:PetSortList;
      
      private var petType:int;
      
      private var curHallowsInfo:PetHallowsInfo;
      
      private var equipPet:PetData;
      
      public function PetHallowsView()
      {
         super();
         initView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("PetHallowsView.back");
         petBack = ComponentFactory.Instance.creatComponentByStylename("PetHallowsView.petBack");
         petIcon = ComponentFactory.Instance.creatCustomObject("PetHallowsView.petIcon");
         petStrip = ComponentFactory.Instance.creatCustomObject("PetHallowsView.petStrip");
         restBtn = ComponentFactory.Instance.creatComponentByStylename("PetHallowsView.restBtn");
         canEquipText = ComponentFactory.Instance.creatComponentByStylename("PetHallowsView.canEquipText");
         alertText = ComponentFactory.Instance.creatComponentByStylename("PetHallowsView.alertText");
         rightView = ComponentFactory.Instance.creatCustomObject("PetHallowsView.rightView");
         hallowsMcView = ComponentFactory.Instance.creatCustomObject("PetHallowsView.hallowsMcView");
         noActiveImage = ComponentFactory.Instance.creatComponentByStylename("PetHallowsView.noActiveImage");
         selectPetBtn = ComponentFactory.Instance.creatComponentByStylename("PetHallowsView.selectPetBtn");
         petIcon.mask = createSprite();
         petIcon.buttonMode = true;
         petIcon.mouseEnabled = false;
         petStrip.setCircleArea(160,360,30);
         petStrip.buttonMode = true;
         hallowsMcView.mouseChildren = hallowsMcView.mouseEnabled = false;
         addChild(back);
         addChild(hallowsMcView);
         addChild(noActiveImage);
         noActiveImage.visible = false;
         addChild(petBack);
         addChild(petIcon);
         addChild(petStrip);
         addChild(selectPetBtn);
         addChild(restBtn);
         restBtn.visible = false;
         addChild(canEquipText);
         addChild(alertText);
         addChild(rightView);
         alertText.text = LanguageMgr.GetTranslation("PetHallowsView.alertText.text");
         selectPetBtn.tipData = LanguageMgr.GetTranslation("PetHallowsView.selectPetBtn.tipdata");
      }
      
      private function createSprite() : Sprite
      {
         petSprite = new Sprite();
         petSprite.graphics.beginFill(16777215,1);
         petSprite.graphics.drawCircle(160,360,30);
         petSprite.graphics.endFill();
         addChild(petSprite);
         petSprite.mouseChildren = petSprite.mouseEnabled = false;
         return petSprite;
      }
      
      private function addEvent() : void
      {
         petStrip.addEventListener("click",__onPetSelectHandler);
         selectPetBtn.addEventListener("click",__onPetSelectHandler);
         restBtn.addEventListener("click",__onRestClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(petStrip)
         {
            petStrip.removeEventListener("click",__onPetSelectHandler);
         }
         if(selectPetBtn)
         {
            selectPetBtn.removeEventListener("click",__onPetSelectHandler);
         }
         if(restBtn)
         {
            restBtn.removeEventListener("click",__onRestClickHandler);
         }
      }
      
      private function __onRestClickHandler(param1:MouseEvent) : void
      {
         if(!curHallowsInfo || !equipPet)
         {
            return;
         }
         PetHallowsManager.instance.sendPetHallowsRequest(3,curHallowsInfo.hallowType,0);
      }
      
      public function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc4_:PetTemplate = null;
         if(!model.selectedHallowsTemp)
         {
            return;
         }
         var _loc1_:Array = model.selectedHallowsTemp.EquipPetSonTypes.split(",");
         var _loc3_:String = "";
         _loc2_ = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc4_ = TempleteManager.instance.petTemplateCate.getPetTemplatesBySonType(_loc1_[_loc2_])[0];
            if(_loc4_)
            {
               _loc3_ += _loc4_.TemplateName + ",";
               petType = _loc4_.PetType;
            }
            _loc2_++;
         }
         _loc3_ = _loc3_.substring(0,_loc3_.lastIndexOf(","));
         canEquipText.text = LanguageMgr.GetTranslation("PetHallowsView.canEquipText.text",_loc3_);
         curHallowsInfo = model.getHallowsInfoByHallowsType(model.selectedHallowsTemp.HallowType);
         hallowsMcView.hallowsType = model.selectedHallowsTemp.HallowType;
         if(curHallowsInfo)
         {
            equipPet = playerInfo.getPet(curHallowsInfo.equipPetId);
            hallowsMcView.playCurFrame(11);
            noActiveImage.visible = false;
         }
         else
         {
            equipPet = null;
            hallowsMcView.stopCurFrame(1);
            noActiveImage.visible = true;
         }
         restBtn.visible = equipPet ? true : false;
         selectPetBtn.visible = equipPet ? false : true;
         petIcon.icon = equipPet ? IconFactory.getPetHeadSmallIcon(equipPet.templateId) : null;
         rightView.refreshView();
      }
      
      private function __onPetSelectHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("015",true);
         param1.stopPropagation();
         if(_petList)
         {
            ObjectUtils.disposeObject(_petList);
            _petList = null;
            return;
         }
         if(!model.getHallowsInfoByHallowsType(model.selectedHallowsTemp.HallowType))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetHallowsView.HallowsEquip.noActiveAlert"));
            return;
         }
         if(!checkHasRightPets())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetHallowsView.noRightPet.selectAlert"));
            return;
         }
         LayerManager.Instance.clearGameMenuLayer();
         if(!_petList)
         {
            _petList = new PetSortList(4,petType);
         }
         _petList.addEventListener("dispose",__onPetListDispose);
         var _loc2_:Point = new Point(petIcon.x,petIcon.y);
         _petList.x = localToGlobal(_loc2_).x + 60;
         _petList.y = localToGlobal(_loc2_).y + 50;
         LayerManager.Instance.addToLayer(_petList,7);
      }
      
      private function __onPetListDispose(param1:Event) : void
      {
         _petList.removeEventListener("dispose",__onPetListDispose);
         ObjectUtils.disposeObject(_petList);
         _petList = null;
      }
      
      private function checkHasRightPets() : Boolean
      {
         var _loc2_:Array = [];
         for each(var _loc1_:PetData in playerInfo.petList)
         {
            if(_loc1_.template.PetType == petType)
            {
               _loc2_.push(_loc1_);
            }
         }
         return _loc2_.length > 0;
      }
      
      private function get model() : PetHallowsModel
      {
         return PetHallowsManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(petBack);
         petBack = null;
         ObjectUtils.disposeObject(petIcon);
         petIcon = null;
         ObjectUtils.disposeObject(canEquipText);
         canEquipText = null;
         ObjectUtils.disposeObject(alertText);
         alertText = null;
         ObjectUtils.disposeObject(rightView);
         rightView = null;
         ObjectUtils.disposeObject(_petList);
         _petList = null;
         ObjectUtils.disposeObject(petStrip);
         petStrip = null;
         ObjectUtils.disposeObject(hallowsMcView);
         hallowsMcView = null;
         ObjectUtils.disposeObject(restBtn);
         restBtn = null;
         ObjectUtils.disposeObject(noActiveImage);
         noActiveImage = null;
         ObjectUtils.disposeObject(petSprite);
         petSprite = null;
         ObjectUtils.disposeObject(selectPetBtn);
         selectPetBtn = null;
         super.dispose();
      }
   }
}

