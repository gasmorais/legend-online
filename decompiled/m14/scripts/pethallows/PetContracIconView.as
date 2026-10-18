package pethallows
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.pet.pethallows.PetHallowsModel;
   import yishi.datas.templates.PetContracTemplateInfo;
   import yishi.datas.templates.PetTemplate;
   import yishi.filter.UIFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PetHallowsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class PetContracIconView extends Component
   {
      
      private var back:Bitmap;
      
      private var overBg:Bitmap;
      
      private var petIcon:BaseIconView;
      
      private var lightImage:Image;
      
      private var lightMc:MovieClip;
      
      private var alertMc:MovieClip;
      
      private var petSprite:Sprite;
      
      private var _data:PetContracTemplateInfo;
      
      private var _filter:UIFilter;
      
      public function PetContracIconView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatBitmap("asset.PetContracIconView.back");
         overBg = ComponentFactory.Instance.creatBitmap("asset.PetContracIconView.overBg");
         alertMc = ComponentFactory.Instance.creatCustomObject("PetContracIconView.alertMc");
         petIcon = ComponentFactory.Instance.creatCustomObject("PetContracIconView.petIcon");
         lightImage = ComponentFactory.Instance.creatComponentByStylename("PetContracIconView.lightImage");
         addChild(back);
         addChild(overBg);
         overBg.visible = false;
         addChild(alertMc);
         addChild(petIcon);
         addChild(lightImage);
         lightImage.mouseEnabled = false;
         this.mouseEnabled = false;
         alertMc.mouseChildren = alertMc.mouseEnabled = false;
         alertMc.stop();
         alertMc.visible = false;
         _filter = new UIFilter();
         petIcon.mask = createSprite();
         petIcon.buttonMode = true;
      }
      
      private function createSprite() : Sprite
      {
         petSprite = new Sprite();
         petSprite.graphics.beginFill(16777215,1);
         petSprite.graphics.drawCircle(35,35,30);
         petSprite.graphics.endFill();
         addChild(petSprite);
         return petSprite;
      }
      
      private function addEvent() : void
      {
         if(petIcon)
         {
            petIcon.addEventListener("click",__iconClickHandler);
            petIcon.addEventListener("mouseOver",__onMouseOverHandler);
            petIcon.addEventListener("mouseOut",__onMouseOutHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(petIcon)
         {
            petIcon.removeEventListener("click",__iconClickHandler);
            petIcon.removeEventListener("mouseOver",__onMouseOverHandler);
            petIcon.removeEventListener("mouseOut",__onMouseOutHandler);
         }
      }
      
      private function __iconClickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("pethallows",2,_data);
      }
      
      private function __onMouseOverHandler(param1:MouseEvent) : void
      {
         overBg.visible = true;
      }
      
      private function __onMouseOutHandler(param1:MouseEvent) : void
      {
         overBg.visible = false;
      }
      
      public function set data(param1:PetContracTemplateInfo) : void
      {
         var _loc6_:int = 0;
         var _loc3_:PetContracTemplateInfo = null;
         var _loc2_:PetContracTemplateInfo = null;
         _data = param1;
         alertMc.visible = false;
         alertMc.stop();
         if(!_data)
         {
            return;
         }
         var _loc4_:PetTemplate = TempleteManager.instance.petTemplateCate.getPetTemplatesBySonType(_data.PetSonType)[0];
         if(!_loc4_)
         {
            return;
         }
         var _loc5_:String = IconFactory.getPetHeadSmallIcon(_loc4_.TemplateId);
         if(petIcon.icon != _loc5_)
         {
            petIcon.icon = _loc5_;
         }
         if(model.contracInfoDic[_data.PetSonType])
         {
            _loc6_ = int(model.contracInfoDic[_data.PetSonType]);
            _loc3_ = TempleteManager.instance.petContracTemplateCate.getTemplateById(_loc6_);
            _loc2_ = model.getContracTempInfoByPetSonTypeAndGrade(_loc3_.PetSonType,_loc3_.Grades + 1);
            if(_loc2_ && model.checkIsCanContrac(_data))
            {
               alertMc.visible = true;
               alertMc.play();
            }
            _filter.setNormalFilter(petIcon);
            this.tipData = _loc4_.TemplateName + LanguageMgr.GetTranslation("PetContracIconView.petIcon.hasactive") + "\n" + LanguageMgr.GetTranslation("PetContracIconView.petIcon.processNum",_loc3_.Grades,6);
         }
         else
         {
            _filter.setGrayFilter(petIcon);
            this.tipData = _loc4_.TemplateName + LanguageMgr.GetTranslation("PetContracIconView.petIcon.noactive");
         }
      }
      
      public function playLightMc() : void
      {
         if(!lightMc)
         {
            lightMc = ComponentFactory.Instance.creatCustomObject("PetContracIconView.lightMc");
            lightMc.mouseChildren = lightMc.mouseEnabled = false;
         }
         if(!lightMc.parent)
         {
            addChild(lightMc);
         }
         lightMc.gotoAndPlay(1);
      }
      
      private function get model() : PetHallowsModel
      {
         return PetHallowsManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _filter = null;
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(overBg);
         overBg = null;
         ObjectUtils.disposeObject(petIcon);
         petIcon = null;
         ObjectUtils.disposeObject(lightImage);
         lightImage = null;
         ObjectUtils.disposeObject(petSprite);
         petSprite = null;
         ObjectUtils.disposeViolentMc(lightMc);
         lightMc = null;
         ObjectUtils.disposeObject(petSprite);
         petSprite = null;
         ObjectUtils.disposeViolentMc(alertMc);
         alertMc = null;
         super.dispose();
      }
   }
}

