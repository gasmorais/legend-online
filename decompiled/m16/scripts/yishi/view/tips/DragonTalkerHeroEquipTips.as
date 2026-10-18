package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dragontalker.DragonTalkerViewHelper;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerSymbioteInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GoodsHelp;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class DragonTalkerHeroEquipTips extends BaseTip
   {
      
      private var back:ScaleBitmapImage;
      
      private var equipIcon:BaseIconView;
      
      private var nameText:FilterFrameText;
      
      private var descText:FilterFrameText;
      
      private var castContnier:Component;
      
      private var mountContiner:Component;
      
      private var refreshContiner:Component;
      
      private var refreshTitle:FilterFrameText;
      
      private var info:GoodsInfo;
      
      private var tempInfo:GoodsTemplateInfo;
      
      private var index:int;
      
      private var symbioteInfo:DragonTalkerSymbioteInfo;
      
      public function DragonTalkerHeroEquipTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerHeroEquipTips.back");
         equipIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         nameText = ComponentFactory.Instance.creatComponentByStylename("tips.GoodNameText_3");
         descText = ComponentFactory.Instance.creatComponentByStylename("tips.castSelectedTxt");
         castContnier = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerHeroEquipTips.castContnier");
         mountContiner = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerHeroEquipTips.mountContiner");
         refreshContiner = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerHeroEquipTips.refreshContiner");
         refreshTitle = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerHeroEquipTips.refreshTitle");
         addChild(back);
         addChild(equipIcon);
         addChild(nameText);
         addChild(descText);
         addChild(castContnier);
         addChild(mountContiner);
         addChild(refreshContiner);
         refreshTitle.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.EquipTipsContent.refreshAdd");
         equipIcon.x = 16;
         equipIcon.y = 11;
         descText.y = 40;
         nameText.x = 75;
      }
      
      override protected function updateTransform() : void
      {
         if(tipData)
         {
            ObjectUtils.disposeAllChildren(castContnier);
            ObjectUtils.disposeAllChildren(mountContiner);
            ObjectUtils.disposeAllChildren(refreshContiner);
            info = tipData as GoodsInfo;
            index = DragonTalkerViewHelper.GetIndexByPos(info.pos);
            symbioteInfo = model.getSymbioteInfoByIndex(index);
            tempInfo = info.templateInfo;
            nameText.setFrame(tempInfo.Profile);
            nameText.text = tempInfo.TemplateName;
            equipIcon.icon = IconFactory.getGoodsIconByTID(tempInfo.TemplateId);
            descText.text = LanguageMgr.GetTranslation("DragonTalkerTalismanTips.equipText.equip");
            initAttView();
            initGemView();
            initRefreshView();
         }
      }
      
      private function initAttView() : void
      {
         var _loc5_:int = 0;
         var _loc10_:String = null;
         var _loc1_:int = 0;
         var _loc3_:DragonTalkerAttTipsItem = null;
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc8_:String = null;
         var _loc6_:Array = tempInfo.hasValueAtt;
         var _loc4_:int = int(_loc6_.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc10_ = _loc6_[_loc5_];
            _loc1_ = int(tempInfo[_loc10_]);
            _loc3_ = new DragonTalkerAttTipsItem();
            _loc2_ = getAdd(_loc1_,info);
            _loc7_ = getNewAdd(_loc1_,info);
            _loc9_ = _loc1_ + _loc2_ + getConciseValue(_loc2_) + _loc7_ + getConciseValue(_loc7_);
            if(symbioteInfo.addPercent != 0)
            {
               _loc9_ = Math.floor(symbioteInfo.addPercent * _loc9_ / 100);
            }
            _loc8_ = LanguageMgr.GetTranslation("DragonTalkerTalismanTips.mainAttText.text" + _loc10_,_loc9_);
            _loc3_.setData(_loc8_);
            _loc3_.x = 140 * _loc5_;
            castContnier.addChild(_loc3_);
            _loc5_++;
         }
      }
      
      private function initGemView() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:HeroGemTipItem = null;
         if(info && tempInfo && tempInfo.StrengthenMax > 0)
         {
            _loc2_ = info.templateInfo.Profile >= 5 ? 4 : 3;
         }
         _loc3_ = 1;
         while(_loc3_ <= _loc2_)
         {
            _loc1_ = new HeroGemTipItem();
            _loc1_.setData(info["join" + _loc3_],info.objectId,symbioteInfo.addPercent);
            _loc1_.x = _loc3_ % 2 == 0 ? 140 : 0;
            _loc1_.y = _loc3_ / 3 >= 1 ? 45 : 0;
            mountContiner.addChild(_loc1_);
            _loc3_++;
         }
      }
      
      private function initRefreshView() : void
      {
         var _loc5_:int = 0;
         var _loc7_:SkillTempInfo = null;
         var _loc6_:* = null;
         var _loc2_:DragonTalkerAttTipsItem = null;
         var _loc4_:String = "";
         var _loc1_:Boolean = false;
         refreshContiner.addChild(refreshTitle);
         _loc5_ = 1;
         while(_loc5_ < 6)
         {
            _loc4_ += info["randomSkill" + _loc5_] + ",";
            if(info["randomSkill" + _loc5_] != 0)
            {
               _loc1_ = true;
            }
            _loc5_++;
         }
         if(_loc1_ == false)
         {
            _loc4_ = info.templateInfo.DefaultSkill;
         }
         var _loc3_:Array = TempleteManager.instance.getSkillTemplateInfoByIds(_loc4_);
         _loc5_ = 0;
         while(_loc5_ < _loc3_.length)
         {
            _loc7_ = _loc3_[_loc5_] as SkillTempInfo;
            if(_loc7_)
            {
               _loc2_ = new DragonTalkerAttTipsItem();
               _loc2_.setData(getRefreshStr(_loc7_,info.objectId));
               _loc2_.x = _loc5_ % 2 == 0 ? 0 : 135;
               _loc2_.y = int(_loc5_ / 2) * 20 + 20;
               refreshContiner.addChild(_loc2_);
            }
            _loc5_++;
         }
      }
      
      private function getRefreshStr(param1:SkillTempInfo, param2:int) : String
      {
         var _loc6_:int = 0;
         var _loc10_:String = null;
         var _loc4_:int = 0;
         var _loc8_:String = null;
         var _loc9_:int = 0;
         var _loc3_:SkillPropertyTempInfo = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(param1.TemplateId);
         if(!_loc3_)
         {
            return "";
         }
         var _loc7_:Array = _loc3_.hasValueAtt;
         var _loc5_:int = int(_loc7_.length);
         var _loc11_:String = "";
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc10_ = _loc7_[_loc6_];
            _loc4_ = int(_loc3_[_loc10_]);
            _loc8_ = LanguageMgr.GetTranslation("DragonTalkerTalismanTips.mainAttText.text" + _loc10_,"");
            _loc9_ = _loc4_ + GoodsHelp.getConciseValue(_loc4_,thane.conciseGrades);
            if(symbioteInfo.addPercent != 0)
            {
               _loc9_ = Math.floor(_loc9_ * symbioteInfo.addPercent / 100);
            }
            _loc11_ += _loc8_ + _loc9_ + "   ";
            _loc6_++;
         }
         return _loc11_;
      }
      
      private function getAdd(param1:int, param2:GoodsInfo) : int
      {
         return GoodsHelp.getStrengthenAddition(param1,param2.strengthenGrade);
      }
      
      private function getNewAdd(param1:int, param2:GoodsInfo) : int
      {
         var _loc4_:int = 0;
         var _loc3_:GoodsTemplateInfo = param2.templateInfo;
         if(_loc3_.StrengthenMax > 0 && _loc3_.Profile >= 5 && _loc3_.NeedGrades >= 50)
         {
            if(param2.mouldGrade > 0)
            {
               return int(GoodsHelp.getMouldAddition(param1,getPropertyMouldGrade(param2)));
            }
         }
         return 0;
      }
      
      private function getConciseValue(param1:int) : int
      {
         var _loc2_:int = 0;
         if(info.objectId == thane.id)
         {
            _loc2_ = int(GoodsHelp.getConciseValue(param1,thane.conciseGrades));
         }
         return _loc2_;
      }
      
      private function getPropertyMouldGrade(param1:GoodsInfo) : int
      {
         if(param1.mouldGrade < 1)
         {
            return 1;
         }
         if(param1.mouldGrade > param1.MOULD_MAX_GRADE)
         {
            return param1.MOULD_MAX_GRADE;
         }
         return param1.mouldGrade;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      override public function get height() : Number
      {
         if(back)
         {
            return back.height;
         }
         return super.height;
      }
      
      override public function get width() : Number
      {
         if(back)
         {
            return back.width;
         }
         return super.width;
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}

