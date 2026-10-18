package planeswar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.PlanesWarEvent;
   import manager.LanguageMgr;
   import mvc.module.planeswar.PlanesWarModel;
   import mvc.module.planeswar.info.PlanesLayerInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.PlanesLayerTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlanesWarManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class PlanesRightView extends Component
   {
      
      private var titleBack2:Image;
      
      private var layerBack:ScaleBitmapImage;
      
      private var layerTextImage:Image;
      
      private var occupyText:FilterFrameText;
      
      private var skillDesc:FilterFrameText;
      
      private var rewardAlertText:FilterFrameText;
      
      private var resiText:FilterFrameText;
      
      private var rewardHbox:HBox;
      
      private var itemObj:Object = {};
      
      private var layerInfo:PlanesLayerInfo;
      
      private var layerTempInfo:PlanesLayerTemplateInfo;
      
      public function PlanesRightView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleBack2 = ComponentFactory.Instance.creatComponentByStylename("PlanesRightView.titleBack2");
         layerBack = ComponentFactory.Instance.creatComponentByStylename("PlanesRightView.layerBack");
         layerTextImage = ComponentFactory.Instance.creatComponentByStylename("PlanesRightView.layerTextImage");
         occupyText = ComponentFactory.Instance.creatComponentByStylename("PlanesRightView.occupyText");
         skillDesc = ComponentFactory.Instance.creatComponentByStylename("PlanesRightView.skillDesc");
         rewardAlertText = ComponentFactory.Instance.creatComponentByStylename("PlanesRightView.rewardAlertText");
         resiText = ComponentFactory.Instance.creatComponentByStylename("PlanesRightView.resiText");
         rewardHbox = ComponentFactory.Instance.creatComponentByStylename("PlanesRightView.rewardHbox");
         addChild(layerBack);
         addChild(titleBack2);
         addChild(layerTextImage);
         addChild(occupyText);
         addChild(skillDesc);
         addChild(rewardAlertText);
         addChild(resiText);
         addChild(rewardHbox);
         rewardAlertText.text = LanguageMgr.GetTranslation("PlanesLeftView.rewardAlertText.text");
         refreshView();
      }
      
      private function addEvent() : void
      {
         PlanesWarManager.instance.addEventListener("PLANES_LAYERLIST_UPDATE",__layerListUpdate);
      }
      
      private function removeEvent() : void
      {
         PlanesWarManager.instance.removeEventListener("PLANES_LAYERLIST_UPDATE",__layerListUpdate);
      }
      
      private function __layerListUpdate(param1:PlanesWarEvent) : void
      {
         refreshView();
      }
      
      public function refreshView() : void
      {
         var _loc6_:int = 0;
         var _loc4_:Array = null;
         var _loc2_:BaseItemView = null;
         var _loc5_:GoodsInfo = null;
         if(model.planesWarInfo.isHideLayer)
         {
            this.visible = false;
            return;
         }
         rewardHbox.removeAllChild();
         var _loc8_:String = LanguageMgr.GetTranslation("PlanesLeftView.layerInfoText.resiText");
         layerInfo = model.getPlanesLayerInfoById(model.planesWarInfo.layerId);
         layerTempInfo = TempleteManager.instance.planesLayerTemplateCate.getTemplateByID(model.planesWarInfo.layerTempId);
         if(layerInfo.occupyUserId == ArmyManager.instance.thane.userId)
         {
            occupyText.text = LanguageMgr.GetTranslation("PlanesRightView.occupyText.text1");
         }
         else
         {
            occupyText.text = LanguageMgr.GetTranslation("PlanesRightView.occupyText.text2");
         }
         occupyText.y = occupyText.numLines > 1 ? 35 : 45;
         var _loc7_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(layerTempInfo.EnemySkill);
         skillDesc.text = _loc7_.Description;
         if(layerTempInfo.ReduceResiBonus != 0)
         {
            _loc8_ += LanguageMgr.GetTranslation("PlanesLeftView.layerInfoText.resiText1",layerTempInfo.ReduceResiBonus) + "  ";
         }
         if(layerTempInfo.FireResiBonus != 0)
         {
            _loc8_ += LanguageMgr.GetTranslation("PlanesLeftView.layerInfoText.resiText2",layerTempInfo.FireResiBonus) + "  ";
         }
         if(layerTempInfo.WaterResiBonus != 0)
         {
            _loc8_ += LanguageMgr.GetTranslation("PlanesLeftView.layerInfoText.resiText3",layerTempInfo.WaterResiBonus) + "  ";
         }
         if(layerTempInfo.ElectResiBonus != 0)
         {
            _loc8_ += LanguageMgr.GetTranslation("PlanesLeftView.layerInfoText.resiText4",layerTempInfo.ElectResiBonus) + "  ";
         }
         if(layerTempInfo.WindResiBonus != 0)
         {
            _loc8_ += LanguageMgr.GetTranslation("PlanesLeftView.layerInfoText.resiText5",layerTempInfo.WindResiBonus) + "  ";
         }
         if(layerTempInfo.DarkResiBonus != 0)
         {
            _loc8_ += LanguageMgr.GetTranslation("PlanesLeftView.layerInfoText.resiText6",layerTempInfo.DarkResiBonus) + "  ";
         }
         if(layerTempInfo.LightResiBonus != 0)
         {
            _loc8_ += LanguageMgr.GetTranslation("PlanesLeftView.layerInfoText.resiText7",layerTempInfo.LightResiBonus) + "  ";
         }
         var _loc1_:Array = layerTempInfo.DailyRewards.split("|");
         var _loc3_:int = int(_loc1_.length);
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc4_ = _loc1_[_loc6_].split(",");
            _loc2_ = itemObj[_loc6_];
            if(!_loc2_)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("PlanesLeftView.BaseItemView");
               itemObj[_loc6_] = _loc2_;
            }
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _loc4_[0];
            _loc5_.count = _loc4_[1];
            _loc2_.data = _loc5_;
            rewardHbox.addChild(_loc2_);
            _loc6_++;
         }
         if(layerTempInfo.ReduceResiBonus == 0 && layerTempInfo.FireResiBonus == 0 && layerTempInfo.WaterResiBonus == 0 && layerTempInfo.ElectResiBonus == 0 && layerTempInfo.WindResiBonus == 0 && layerTempInfo.DarkResiBonus == 0 && layerTempInfo.LightResiBonus == 0)
         {
            resiText.htmlText = "";
         }
         else
         {
            resiText.htmlText = _loc8_;
         }
         skillDesc.height = skillDesc.textHeight + 5;
         rewardAlertText.y = skillDesc.y + skillDesc.textHeight;
         resiText.y = rewardAlertText.y + rewardAlertText.textHeight;
         rewardHbox.y = resiText.y + resiText.textHeight + 5;
      }
      
      private function get model() : PlanesWarModel
      {
         return PlanesWarManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(layerBack)
         {
            ObjectUtils.disposeObject(layerBack);
         }
         layerBack = null;
         if(titleBack2)
         {
            ObjectUtils.disposeObject(titleBack2);
         }
         titleBack2 = null;
         if(layerTextImage)
         {
            ObjectUtils.disposeObject(layerTextImage);
         }
         layerTextImage = null;
         if(occupyText)
         {
            ObjectUtils.disposeObject(occupyText);
         }
         occupyText = null;
         if(skillDesc)
         {
            ObjectUtils.disposeObject(skillDesc);
         }
         skillDesc = null;
         if(rewardAlertText)
         {
            ObjectUtils.disposeObject(rewardAlertText);
         }
         rewardAlertText = null;
         if(resiText)
         {
            ObjectUtils.disposeObject(resiText);
         }
         resiText = null;
         if(rewardHbox)
         {
            ObjectUtils.disposeObject(rewardHbox);
         }
         rewardHbox = null;
         if(itemObj)
         {
            for(var _loc1_:String in itemObj)
            {
               ObjectUtils.disposeObject(itemObj[_loc1_]);
               itemObj[_loc1_] = null;
            }
            itemObj = null;
         }
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

