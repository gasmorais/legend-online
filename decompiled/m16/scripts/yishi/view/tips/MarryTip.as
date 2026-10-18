package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import mvc.module.marry.MarryInfo;
   import mvc.module.marry.MarryTipData;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignBufferTemp;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseIconView;
   
   public class MarryTip extends BaseTip
   {
      
      private var _vBox:VBox;
      
      private var _purpleBg:Scale9CornerImage;
      
      private var _itemIcon:BaseIconView;
      
      private var _profileImg:ScaleFrameImage;
      
      private var _itemNameTxt:FilterFrameText;
      
      private var _itemNameLevel:FilterFrameText;
      
      private var _partnerName:FilterFrameText;
      
      private var _splitLine01:Bitmap;
      
      private var _splitLine02:Bitmap;
      
      public function MarryTip()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _vBox = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassVBox");
         _purpleBg = ComponentFactory.Instance.creatComponentByStylename("core.purpleItemTipsBg");
         _itemIcon = ComponentFactory.Instance.creatCustomObject("tips.showItemBaseItemViewIcon");
         _profileImg = ComponentFactory.Instance.creatComponentByStylename("tips.profileImg");
         _splitLine01 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _splitLine02 = ComponentFactory.Instance.creatBitmap("asset.tips.splitLine");
         _partnerName = ComponentFactory.Instance.creatComponentByStylename("tips.MarryTip.LoverName");
         _splitLine01.width = 220;
         _splitLine02.width = 220;
         addChild(_vBox);
         _purpleBg.y = 0;
         _itemIcon.x = 9;
         _profileImg.x = 8;
      }
      
      override protected function updateTransform() : void
      {
         var _loc13_:MarryTipData = null;
         var _loc9_:FilterFrameText = null;
         var _loc14_:ScaleBitmapImage = null;
         var _loc18_:Dictionary = null;
         var _loc1_:Array = null;
         var _loc3_:UpgradeTemplateInfo = null;
         var _loc12_:SkillTempInfo = null;
         var _loc4_:String = null;
         var _loc15_:* = null;
         var _loc10_:* = null;
         var _loc2_:int = 0;
         var _loc16_:int = 0;
         var _loc5_:int = 0;
         var _loc17_:CampaignBufferTemp = null;
         var _loc11_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         if(tipData)
         {
            _vBox.y = 10;
            _vBox.removeAllChild();
            if(_itemNameTxt && _itemNameTxt.parent)
            {
               _itemNameTxt.parent.removeChild(_itemNameTxt);
            }
            if(_itemNameLevel && _itemNameLevel.parent)
            {
               _itemNameLevel.parent.removeChild(_itemNameLevel);
            }
            _loc13_ = tipData as MarryTipData;
            _loc18_ = new Dictionary();
            _loc1_ = [];
            _loc4_ = "";
            _partnerName.visible = true;
            if(_loc13_.type == 1)
            {
               _loc1_ = TempleteManager.instance.getTemplatesByType(36);
               _loc1_.sortOn("TemplateId",16);
               _loc2_ = int(_loc1_.length);
               _loc16_ = 0;
               _loc5_ = 0;
               while(_loc5_ < _loc2_)
               {
                  if(_loc1_[_loc5_].TemplateId > MarryManager.instance.model.marriageData.happyInfo.happyGp)
                  {
                     if(_loc1_[_loc5_ - 1])
                     {
                        _loc2_ = int(_loc1_[_loc5_ - 1].Grades);
                     }
                     _loc16_ = int(_loc1_[_loc5_].TemplateId);
                     break;
                  }
                  _loc5_++;
               }
               _loc17_ = TempleteManager.instance.campaignBufferTemplate.getTemplateByTypeAndGrades(30,_loc2_);
               if(_loc17_ == null)
               {
                  _vBox.refreshChildPos();
                  _bg.width = _vBox.displayWidth + 20;
                  _bg.height = _vBox.displayHeight + 20;
                  hidendProfileBg();
                  setChildIndex(_vBox,numChildren - 1);
                  return;
               }
               _loc9_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
               _loc9_.text = LanguageMgr.GetTranslation("yishi.view.tips.MarryTip.BuffName",_loc17_.Grades);
               _loc9_.setFrame(8);
               if(!StringHelper.isNullOrEmpty(_loc17_.Description))
               {
                  _loc11_ = _loc17_.Description.split("|");
                  _loc7_ = 0;
                  while(_loc7_ < _loc11_.length)
                  {
                     _loc9_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                     _loc9_.text = _loc11_[_loc7_];
                     _loc9_.setFrame(2);
                     _vBox.addChild(_loc9_);
                     _loc7_++;
                  }
               }
               _loc17_ = TempleteManager.instance.campaignBufferTemplate.getTemplateByTypeAndGrades(30,_loc2_ + 1);
               if(_loc17_ == null)
               {
                  _vBox.refreshChildPos();
                  _bg.width = _vBox.displayWidth + 20;
                  _bg.height = _vBox.displayHeight + 20;
                  hidendProfileBg();
                  setChildIndex(_vBox,numChildren - 1);
                  return;
               }
               _loc14_ = ComponentFactory.Instance.creatComponentByStylename("tips.TaskTraceLine");
               _vBox.addChild(_loc14_);
               _loc9_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
               _loc9_.text = LanguageMgr.GetTranslation("yishi.view.tips.MarryTip.NextGrades",_loc16_);
               _loc9_.setFrame(4);
               _vBox.addChild(_loc9_);
               _loc9_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
               _loc9_.text = LanguageMgr.GetTranslation("yishi.view.tips.MarryTip.BuffName",_loc2_ + 1);
               _loc9_.setFrame(8);
               _vBox.addChild(_loc9_);
               if(!StringHelper.isNullOrEmpty(_loc17_.Description))
               {
                  _loc11_ = _loc17_.Description.split("|");
                  _loc8_ = 0;
                  while(_loc8_ < _loc11_.length)
                  {
                     _loc9_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                     _loc9_.text = _loc11_[_loc8_];
                     _loc9_.setFrame(2);
                     _vBox.addChild(_loc9_);
                     _loc8_++;
                  }
               }
            }
            else if(_loc13_.type == 2)
            {
               _vBox.y = 54;
               _profileImg.setFrame(4);
               _loc3_ = TempleteManager.instance.getTemplateByLevelAndType(_loc13_.grades,36);
               if(_loc3_ == null)
               {
                  return;
               }
               _itemNameTxt = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
               _itemNameTxt.text = LanguageMgr.GetTranslation("yishi.view.tips.MarryTip.RingGradesName",_loc13_.grades);
               _itemNameTxt.setFrame(3);
               _itemNameLevel = ComponentFactory.Instance.creatComponentByStylename("tips.marryTipNameLevel");
               _itemNameLevel.text = LanguageMgr.GetTranslation("yishi.view.tips.MarryTip.RingGradesNameLevel",_loc13_.grades);
               _itemIcon.icon = IconFactory.getMarryRingIcon(_loc13_.grades > 9 ? 9 : _loc13_.grades);
               if(_loc13_.nickNameB)
               {
                  _partnerName.htmlText = LanguageMgr.GetTranslation("yishi.view.tips.MarryTip.LoverName",_loc13_.nickNameB);
               }
               else
               {
                  _partnerName.htmlText = LanguageMgr.GetTranslation("yishi.view.tips.MarryTip.LoverNameNull");
               }
               _itemNameLevel.y = 36;
               _itemNameLevel.x = 106;
               _itemNameTxt.x = 75;
               _itemNameTxt.y = 15;
            }
            else if(_loc13_.type == 3)
            {
               _loc3_ = TempleteManager.instance.getTemplateByLevelAndType(_loc13_.grades,36);
               if(_loc3_ == null)
               {
                  hidendProfileBg();
                  setChildIndex(_vBox,numChildren - 1);
                  return;
               }
               _loc1_ = TempleteManager.instance.getSkillTemplateInfoByIds(_loc13_.skillId);
               _loc6_ = 0;
               while(_loc6_ < _loc1_.length)
               {
                  _loc12_ = _loc1_[_loc6_] as SkillTempInfo;
                  if(_loc12_ == null)
                  {
                     break;
                  }
                  if(_loc12_.UseWay == 1)
                  {
                     _loc4_ += LanguageMgr.GetTranslation("yishi.view.tips.MarryTip.SkillDecribe1",_loc12_.Description) + "\n";
                     _loc9_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                     _loc9_.text = LanguageMgr.GetTranslation("yishi.view.tips.MarryTip.SkillName") + _loc12_.TemplateName + "  " + LanguageMgr.GetTranslation("public.level2",_loc12_.Grades);
                     _loc9_.setFrame(3);
                     _loc9_.setTextFormat(ComponentFactory.Instance.model.getSet("tips.SinglePassRewardTxt_t8"),_loc9_.length - 2,_loc9_.length);
                     _vBox.addChild(_loc9_);
                     _loc9_ = ComponentFactory.Instance.creatComponentByStylename("tips.SinglePassRewardTxt");
                     _loc9_.text = LanguageMgr.GetTranslation("yishi.view.tips.goods.SkillTips.cooldown01",_loc12_.CoolDown / 1000);
                     _loc9_.setFrame(8);
                     _vBox.addChild(_loc9_);
                  }
                  else if(_loc12_.UseWay == 2)
                  {
                     _loc4_ += LanguageMgr.GetTranslation("yishi.view.tips.MarryTip.SkillDecribe2",_loc12_.Description) + "\n";
                  }
                  _loc6_++;
               }
               _loc9_ = ComponentFactory.Instance.creatComponentByStylename("tips.MarryTipsDescribeText");
               _loc9_.htmlText = _loc4_;
               _vBox.addChild(_loc9_);
               _partnerName.visible = false;
            }
            _vBox.refreshChildPos();
            _bg.width = _vBox.displayWidth + 20;
            _bg.height = _vBox.y + _vBox.displayHeight + 10;
            hidendProfileBg();
            if(_loc13_.type == 2)
            {
               if(_bg.width < 237)
               {
                  _bg.width = 237;
               }
               _itemIcon.visible = true;
               _profileImg.visible = true;
               _purpleBg.width = _bg.width;
               _purpleBg.height = _bg.height;
               showProfileBg(4);
               addChild(_itemNameLevel);
               addChild(_itemNameTxt);
               addChild(_partnerName);
            }
            setChildIndex(_vBox,numChildren - 1);
         }
      }
      
      private function hidendProfileBg() : void
      {
         _bg.visible = true;
         if(_purpleBg.parent)
         {
            removeChild(_purpleBg);
         }
         if(_itemIcon.parent)
         {
            removeChild(_itemIcon);
         }
         if(_profileImg.parent)
         {
            removeChild(_profileImg);
         }
      }
      
      private function showProfileBg(param1:int) : void
      {
         _bg.visible = false;
         addChild(_purpleBg);
         addChild(_itemIcon);
         addChild(_profileImg);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get info() : MarryInfo
      {
         return MarryManager.instance.model.selfMarryInfo;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

