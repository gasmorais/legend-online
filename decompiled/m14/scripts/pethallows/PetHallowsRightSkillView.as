package pethallows
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.pet.pethallows.PetHallowsInfo;
   import mvc.module.pet.pethallows.PetHallowsModel;
   import utils.LogicUtils;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.PetHallowsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PetHallowsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class PetHallowsRightSkillView extends Component
   {
      
      private var typeImage:ScaleFrameImage;
      
      private var levelText:FilterFrameText;
      
      private var helpImage:Image;
      
      private var skillBack:MutipleImage;
      
      private var skillIcon:BaseIconView;
      
      private var skillLevelText:FilterFrameText;
      
      private var breakMc:MovieClip;
      
      private var itemContiner:Component;
      
      private var itemList:Vector.<PetHallowsPropAddItem>;
      
      private var bottomContiner:Component;
      
      private var bottomBack:MutipleImage;
      
      private var feedBtn:IconButton;
      
      private var breakBtn:IconButton;
      
      private var feedStoneText1:FilterFrameText;
      
      private var feedStoneText2:FilterFrameText;
      
      private var feedStoneImage1:ScaleFrameImage;
      
      private var feedStoneImage2:ScaleFrameImage;
      
      private var needStoneText:FilterFrameText;
      
      private var hasStoneText:FilterFrameText;
      
      private var maxImage:MutipleImage;
      
      private var isCountReach:Boolean;
      
      private var curViewType:int;
      
      public function PetHallowsRightSkillView()
      {
         super();
         initView();
         initPropListView();
         addEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         typeImage = ComponentFactory.Instance.creatComponentByStylename("PetHallowsRightSkillView.typeImage");
         levelText = ComponentFactory.Instance.creatComponentByStylename("PetHallowsRightSkillView.levelText");
         helpImage = ComponentFactory.Instance.creatComponentByStylename("PetHallowsRightSkillView.helpImage");
         skillBack = ComponentFactory.Instance.creatComponentByStylename("PetHallowsRightSkillView.skillBack");
         skillIcon = ComponentFactory.Instance.creatCustomObject("PetHallowsRightSkillView.skillIcon");
         skillLevelText = ComponentFactory.Instance.creatComponentByStylename("PetHallowsRightSkillView.skillLevelText");
         breakMc = ComponentFactory.Instance.creatCustomObject("PetHallowsRightSkillView.breakMc");
         itemContiner = ComponentFactory.Instance.creatComponentByStylename("PetHallowsRightSkillView.itemContiner");
         bottomContiner = ComponentFactory.Instance.creatComponentByStylename("PetHallowsRightSkillView.bottomContiner");
         bottomBack = ComponentFactory.Instance.creatComponentByStylename("PetHallowsRightSkillView.bottomBack");
         feedBtn = ComponentFactory.Instance.creatComponentByStylename("PetHallowsRightSkillView.feedBtn");
         breakBtn = ComponentFactory.Instance.creatComponentByStylename("PetHallowsRightSkillView.breakBtn");
         feedStoneText1 = ComponentFactory.Instance.creatComponentByStylename("PetHallowsRightSkillView.feedStoneText1");
         feedStoneText2 = ComponentFactory.Instance.creatComponentByStylename("PetHallowsRightSkillView.feedStoneText2");
         feedStoneImage1 = ComponentFactory.Instance.creatComponentByStylename("PetHallowsRightSkillView.feedStoneImage1");
         feedStoneImage2 = ComponentFactory.Instance.creatComponentByStylename("PetHallowsRightSkillView.feedStoneImage2");
         needStoneText = ComponentFactory.Instance.creatComponentByStylename("PetHallowsRightSkillView.needStoneText");
         hasStoneText = ComponentFactory.Instance.creatComponentByStylename("PetHallowsRightSkillView.hasStoneText");
         maxImage = ComponentFactory.Instance.creatComponentByStylename("PetHallowsRightSkillView.maxImage");
         addChild(typeImage);
         addChild(levelText);
         addChild(helpImage);
         addChild(skillBack);
         addChild(skillIcon);
         addChild(breakMc);
         breakMc.visible = false;
         breakMc.stop();
         addChild(skillLevelText);
         addChild(itemContiner);
         addChild(bottomContiner);
         addChild(maxImage);
         bottomContiner.addChild(bottomBack);
         bottomContiner.addChild(feedStoneText1);
         bottomContiner.addChild(feedStoneText2);
         bottomContiner.addChild(feedStoneImage1);
         bottomContiner.addChild(feedStoneImage2);
         bottomContiner.addChild(needStoneText);
         bottomContiner.addChild(hasStoneText);
         bottomContiner.addChild(feedBtn);
         bottomContiner.addChild(breakBtn);
         breakMc.mouseChildren = breakMc.mouseEnabled = false;
      }
      
      private function initPropListView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PetHallowsPropAddItem = null;
         itemList = new Vector.<PetHallowsPropAddItem>();
         var _loc3_:Array = [[0,0],[40,45],[80,90],[80,130],[40,175],[0,220]];
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = new PetHallowsPropAddItem();
            _loc1_.x = _loc3_[_loc2_][0];
            _loc1_.y = _loc3_[_loc2_][1];
            itemContiner.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         feedBtn.addEventListener("click",__onHallowsTrainHandler);
         breakBtn.addEventListener("click",__onHallowsTrainHandler);
      }
      
      private function removeEvent() : void
      {
         if(feedBtn)
         {
            feedBtn.removeEventListener("click",__onHallowsTrainHandler);
         }
         if(breakBtn)
         {
            breakBtn.removeEventListener("click",__onHallowsTrainHandler);
         }
      }
      
      private function __onHallowsTrainHandler(param1:MouseEvent) : void
      {
         if(!isCountReach)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetHallowsRightSkillView.train.noGoodsAlert"));
            return;
         }
         PetHallowsManager.instance.sendPetHallowsRequest(2,model.selectedHallowsTemp.HallowType);
      }
      
      public function refreshView() : void
      {
         var _loc3_:PetHallowsTemplateInfo = null;
         var _loc8_:PetHallowsTemplateInfo = null;
         var _loc12_:SkillTempInfo = null;
         var _loc7_:String = null;
         var _loc5_:int = 0;
         var _loc13_:int = 0;
         if(!model.selectedHallowsTemp)
         {
            return;
         }
         var _loc4_:Object = {};
         _loc4_.type = 3;
         _loc4_.dic = model.getHallowSkillTempDicByHallowsType(model.selectedHallowsTemp.HallowType);
         helpImage.tipData = _loc4_;
         typeImage.setFrame(model.selectedHallowsTemp.HallowType);
         var _loc1_:PetHallowsInfo = model.getHallowsInfoByHallowsType(model.selectedHallowsTemp.HallowType);
         var _loc9_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208063);
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208064);
         var _loc11_:int = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(208063));
         var _loc6_:int = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(208064));
         if(!_loc1_)
         {
            _loc3_ = model.getHallowsTempInfoByTypeAndGrade(model.selectedHallowsTemp.HallowType,1);
            _loc8_ = model.getHallowsTempInfoByTypeAndGrade(model.selectedHallowsTemp.HallowType,2);
            levelText.text = LanguageMgr.GetTranslation("public.level2",0);
         }
         else
         {
            _loc3_ = _loc1_.templateInfo;
            _loc8_ = model.getHallowsTempInfoByTypeAndGrade(_loc3_.HallowType,_loc3_.Grades + 1);
            levelText.text = LanguageMgr.GetTranslation("public.level2",_loc3_.Grades);
         }
         _loc12_ = TempleteManager.instance.getSkillById(_loc3_.SkillTempId);
         if(_loc12_)
         {
            _loc7_ = IconFactory.getCommonIconPath(_loc12_.Icons);
            if(skillIcon.icon != _loc7_)
            {
               skillIcon.icon = _loc7_;
            }
            skillIcon.tipData = _loc12_;
            skillLevelText.text = LanguageMgr.GetTranslation("public.level2",_loc12_.Grades);
         }
         if(!_loc8_)
         {
            maxImage.visible = true;
            bottomContiner.visible = false;
            curViewType = 0;
         }
         else
         {
            maxImage.visible = false;
            bottomContiner.visible = true;
            if(_loc8_.NeedItemCount1 >= 0 && _loc8_.NeedItemCount2 <= 0)
            {
               feedBtn.enable = _loc1_ ? true : false;
               feedBtn.visible = true;
               breakBtn.visible = false;
               breakMc.visible = false;
               breakMc.stop();
               feedStoneImage1.setFrame(1);
               feedStoneImage2.setFrame(1);
               feedStoneText1.text = feedStoneText2.text = _loc9_.TemplateName;
               needStoneText.text = _loc8_.NeedItemCount1 + "";
               hasStoneText.text = _loc11_ + "";
               isCountReach = _loc11_ >= _loc8_.NeedItemCount1;
               curViewType = 1;
            }
            else
            {
               feedBtn.visible = false;
               breakBtn.visible = true;
               breakBtn.enable = true;
               breakMc.visible = true;
               breakMc.play();
               feedStoneImage1.setFrame(2);
               feedStoneImage2.setFrame(2);
               feedStoneText1.text = feedStoneText2.text = _loc2_.TemplateName;
               needStoneText.text = _loc8_.NeedItemCount2 + "";
               hasStoneText.text = _loc6_ + "";
               isCountReach = _loc6_ >= _loc8_.NeedItemCount2;
               curViewType = 2;
            }
         }
         var _loc10_:Object = {};
         _loc5_ = 0;
         while(_loc5_ < itemList.length)
         {
            _loc10_.propData = _loc1_ ? _loc1_["propAddValue" + _loc5_] : _loc3_.PropertyDatas.split(",")[_loc5_];
            if(curViewType == 1)
            {
               _loc10_.selected = _loc1_ ? _loc1_.infuseIndex == _loc5_ : _loc5_ == 0;
            }
            else
            {
               _loc10_.selected = false;
            }
            if(_loc8_)
            {
               _loc13_ = _loc8_.PropertyDatas.split(",")[_loc5_] - _loc3_.PropertyDatas.split(",")[_loc5_];
            }
            else
            {
               _loc13_ = 0;
            }
            _loc10_.type = model.getLanguageType(_loc5_,_loc3_);
            _loc10_.addValue = _loc13_;
            itemList[_loc5_].data = _loc10_;
            _loc5_++;
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get model() : PetHallowsModel
      {
         return PetHallowsManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(typeImage);
         typeImage = null;
         ObjectUtils.disposeObject(levelText);
         levelText = null;
         ObjectUtils.disposeObject(helpImage);
         helpImage = null;
         ObjectUtils.disposeObject(skillBack);
         skillBack = null;
         ObjectUtils.disposeObject(skillIcon);
         skillIcon = null;
         ObjectUtils.disposeObject(skillLevelText);
         skillLevelText = null;
         ObjectUtils.disposeObject(itemContiner);
         itemContiner = null;
         ObjectUtils.disposeObject(bottomContiner);
         bottomContiner = null;
         ObjectUtils.disposeObject(maxImage);
         maxImage = null;
         ObjectUtils.disposeObject(bottomBack);
         bottomBack = null;
         ObjectUtils.disposeObject(feedStoneText1);
         feedStoneText1 = null;
         ObjectUtils.disposeObject(feedStoneText2);
         feedStoneText2 = null;
         ObjectUtils.disposeObject(feedStoneImage1);
         feedStoneImage1 = null;
         ObjectUtils.disposeObject(feedStoneImage2);
         feedStoneImage2 = null;
         ObjectUtils.disposeObject(needStoneText);
         needStoneText = null;
         ObjectUtils.disposeObject(hasStoneText);
         hasStoneText = null;
         ObjectUtils.disposeObject(feedBtn);
         feedBtn = null;
         ObjectUtils.disposeObject(breakBtn);
         breakBtn = null;
         ObjectUtils.disposeViolentMc(breakMc);
         breakMc = null;
         LogicUtils.disposeDisplayCollection(itemList);
         super.dispose();
      }
   }
}

