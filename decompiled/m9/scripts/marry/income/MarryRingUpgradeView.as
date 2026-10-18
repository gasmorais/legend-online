package marry.income
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import mvc.module.marry.MarryModel;
   import mvc.module.marry.MarrySender;
   import mvc.module.marry.MarryTipData;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.MsgMan;
   import yishi.utils.StringHelper;
   import yishi.view.base.Progress;
   import yishi.view.community.BaseIconView;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class MarryRingUpgradeView extends Sprite implements Disposeable
   {
      
      private var _bg1:Scale9CornerImage;
      
      private var _bg1Right:Scale9CornerImage;
      
      private var _bg2:MutipleImage;
      
      private var _item1:BaseIconView;
      
      private var _item2:BaseIconView;
      
      private var _level1:FilterFrameText;
      
      private var _level2:FilterFrameText;
      
      private var _upBtn1:BaseButton;
      
      private var _upBtn2:BaseButton;
      
      private var _nowVbox:VBox;
      
      private var _nextVbox:VBox;
      
      private var _dic:Dictionary;
      
      private var _coverImage:MutipleImage;
      
      private var _progress:Progress;
      
      private var _proGap:Bitmap;
      
      private var _leftGoods:FilterFrameText;
      
      private var _leftCount:FilterFrameText;
      
      private var _needPoint:int;
      
      private var _propTipsContiner:Component;
      
      private var _currentLevel:int;
      
      private var _killInfoItemNow:MarrySkillInfoItem;
      
      private var _killInfoItemNext:MarrySkillInfoItem;
      
      private var _itemList:Vector.<MarrySkillItem>;
      
      private var _killSprite:Sprite;
      
      public function MarryRingUpgradeView()
      {
         super();
         initData();
         initView();
         initEvent();
      }
      
      private function initData() : void
      {
         _dic = new Dictionary();
         _dic["Power"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip01");
         _dic["Agility"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip02");
         _dic["Intellect"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip03");
         _dic["Physique"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip04");
         _dic["Captain"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip05");
         _dic["Attack"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip06");
         _dic["Defence"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip07");
         _dic["MagicAttack"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip08");
         _dic["MagicDefence"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip09");
         _dic["ForceHit"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip10");
         _dic["Live"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip11");
         _dic["Conat"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip17");
         _dic["Parry"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip19");
         _dic["Penetrate"] = LanguageMgr.GetTranslation("armyII.ThaneAttributeView.Tip25");
         _needPoint = 10;
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("mar_ring_points");
         if(_loc1_ && !StringHelper.isNullOrEmpty(_loc1_.ConfigValue))
         {
            _needPoint = int(_loc1_.ConfigValue);
         }
         _currentLevel = model.marriageData.ringInfo.ringGrade;
      }
      
      private function initView() : void
      {
         var _loc4_:int = 0;
         var _loc2_:MarrySkillItem = null;
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("MarryRingUpgradeFrame.bg1");
         _bg1Right = ComponentFactory.Instance.creatComponentByStylename("MarryRingUpgradeFrame.bg1Right");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("MarryRingUpgradeFrame.bg2");
         _upBtn1 = ComponentFactory.Instance.creatComponentByStylename("MarryRingUpgradeFrame.upBtn1");
         _upBtn2 = ComponentFactory.Instance.creatComponentByStylename("MarryRingUpgradeFrame.upBtn2");
         _item1 = ComponentFactory.Instance.creatCustomObject("MarryRingUpgradeFrame.item1");
         _item2 = ComponentFactory.Instance.creatCustomObject("MarryRingUpgradeFrame.item2");
         _level1 = ComponentFactory.Instance.creatComponentByStylename("MarryRingUpgradeFrame.level1");
         _level2 = ComponentFactory.Instance.creatComponentByStylename("MarryRingUpgradeFrame.level2");
         _nowVbox = ComponentFactory.Instance.creatComponentByStylename("MarryRingUpgradeFrame.LeftVbox");
         _nextVbox = ComponentFactory.Instance.creatComponentByStylename("MarryRingUpgradeFrame.RightVbox");
         _coverImage = ComponentFactory.Instance.creatComponentByStylename("MarryRingUpgradeFrame.ringLimit");
         _progress = ComponentFactory.Instance.creatComponentByStylename("MarryRingUpgradeFrame.progress");
         _proGap = ComponentFactory.Instance.creatBitmap("asset.marry.upRingProGap");
         _leftGoods = ComponentFactory.Instance.creatComponentByStylename("MarryRingUpgradeFrame.leftGoods");
         _leftCount = ComponentFactory.Instance.creatComponentByStylename("MarryRingUpgradeFrame.leftCount");
         _propTipsContiner = ComponentFactory.Instance.creatComponentByStylename("MarryRingUpgradeView.propTipsContiner");
         _killSprite = new Sprite();
         addChild(_bg1);
         addChild(_bg1Right);
         addChild(_bg2);
         addChild(_upBtn1);
         _upBtn1.tipData = LanguageMgr.GetTranslation("marry.income.MarryRingUpgradeFrame.upbtnTips",_needPoint,1,1);
         addChild(_upBtn2);
         _upBtn2.tipData = LanguageMgr.GetTranslation("marry.income.MarryRingUpgradeFrame.upbtnTips",_needPoint * 50,50,50);
         addChild(_item1);
         addChild(_item2);
         addChild(_level1);
         addChild(_level2);
         addChild(_nowVbox);
         addChild(_nextVbox);
         addChild(_coverImage);
         addChild(_progress);
         _progress.x = 217;
         _progress.y = 368;
         addChild(_propTipsContiner);
         _propTipsContiner.addChild(_leftGoods);
         addChild(_leftCount);
         addChild(_killSprite);
         _killSprite.x = 590;
         _killSprite.y = 40;
         _leftGoods.text = LanguageMgr.GetTranslation(_currentLevel >= 9 ? "marry.income.MarryRingUpgradeFrame.leftGoods.text1" : "marry.income.MarryRingUpgradeFrame.leftGoods.text");
         var _loc5_:int = _currentLevel >= 9 ? 208058 : 208036;
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc5_);
         _propTipsContiner.tipData = _loc1_.Description;
         _itemList = new Vector.<MarrySkillItem>();
         var _loc3_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            _loc2_ = new MarrySkillItem();
            _loc2_.x = _loc4_ % 2 * 110;
            _loc2_.y = _loc3_ * 130;
            if(_loc4_ % 2 == 1)
            {
               _loc3_++;
            }
            _killSprite.addChild(_loc2_);
            _itemList.push(_loc2_);
            _loc4_++;
         }
         refreshViewByLevel();
         refreshProgress();
      }
      
      private function refreshViewByLevel() : void
      {
         var _loc8_:int = 0;
         var _loc3_:Array = null;
         var _loc9_:int = 0;
         var _loc7_:MarryTipData = null;
         var _loc5_:* = null;
         _nowVbox.disposeAllChildren();
         _nextVbox.disposeAllChildren();
         var _loc6_:Array = nowInfo.TemplateName.split("|");
         _loc8_ = 0;
         while(_loc8_ < _itemList.length)
         {
            if(_loc6_.length > _loc8_)
            {
               if(_loc6_[_loc8_] != "")
               {
                  _itemList[_loc8_].data = _loc6_[_loc8_];
               }
            }
            _loc8_++;
         }
         var _loc4_:String = "";
         var _loc1_:String = "";
         if(nextInfo)
         {
            _loc3_ = nextInfo.TemplateName.split("|");
            _loc8_ = 0;
            while(_loc8_ < _loc6_.length)
            {
               _loc9_ = _loc3_.indexOf(_loc6_[_loc8_]);
               if(_loc9_ >= 0)
               {
                  _loc3_.splice(_loc9_,1);
                  _loc6_.splice(_loc8_,1);
                  _loc8_--;
               }
               _loc8_++;
            }
            _loc8_ = 0;
            while(_loc8_ < _loc3_.length)
            {
               _loc1_ += _loc3_[_loc8_];
               if(_loc8_ < _loc3_.length - 1)
               {
                  _loc1_ += "|";
               }
               _loc8_++;
            }
            _killInfoItemNext = new MarrySkillInfoItem(_loc1_);
            _nextVbox.addChild(_killInfoItemNext);
            _loc8_ = 0;
            while(_loc8_ < _loc6_.length)
            {
               _loc4_ += _loc6_[_loc8_];
               if(_loc8_ < _loc6_.length - 1)
               {
                  _loc4_ += "|";
               }
               _loc8_++;
            }
            _killInfoItemNow = new MarrySkillInfoItem(_loc4_);
            _nowVbox.addChild(_killInfoItemNow);
         }
         _level1.text = LanguageMgr.GetTranslation("public.level2",_currentLevel);
         var _loc2_:Array = [];
         if(nowInfo)
         {
            _item1.icon = IconFactory.getMarryRingIcon(_currentLevel >= 9 ? 9 : _currentLevel);
            _loc7_ = new MarryTipData();
            _loc7_.type = 2;
            _loc7_.grades = _currentLevel;
            _loc7_.nickNameB = model.selfMarryInfo.nickName;
            _item1.tipData = _loc7_;
            _loc7_ = new MarryTipData();
            _loc7_.type = 3;
            _loc7_.grades = _currentLevel;
         }
         if(nextInfo)
         {
            _item2.icon = IconFactory.getMarryRingIcon(_currentLevel + 1 >= 9 ? 9 : _currentLevel + 1);
            _loc7_ = new MarryTipData();
            _loc7_.type = 2;
            _loc7_.grades = _currentLevel + 1;
            _loc7_.nickNameB = model.selfMarryInfo.nickName;
            _item2.tipData = _loc7_;
            _loc7_ = new MarryTipData();
            _loc7_.type = 3;
            _loc7_.grades = _currentLevel + 1;
            _coverImage.visible = false;
            _item2.visible = true;
            _level2.text = LanguageMgr.GetTranslation("public.level2",_currentLevel + 1);
         }
         else
         {
            _coverImage.visible = true;
            _item2.visible = false;
            _level2.text = "--";
            _upBtn1.enable = _upBtn2.enable = false;
         }
         if(_currentLevel >= 9)
         {
            _upBtn1.tipData = LanguageMgr.GetTranslation("marry.income.MarryRingUpgradeFrame.upbtnTips2",1,1);
            _upBtn2.tipData = LanguageMgr.GetTranslation("marry.income.MarryRingUpgradeFrame.upbtnTips2",10,10);
         }
         else
         {
            _upBtn1.tipData = LanguageMgr.GetTranslation("marry.income.MarryRingUpgradeFrame.upbtnTips",_needPoint,1,1);
            _upBtn2.tipData = LanguageMgr.GetTranslation("marry.income.MarryRingUpgradeFrame.upbtnTips",_needPoint * 50,50,50);
         }
      }
      
      private function refreshProgress() : void
      {
         if(nextInfo)
         {
            _progress.setData(model.marriageData.ringInfo.ringGp,nextInfo.Data);
         }
         else
         {
            _progress.setData(nowInfo.Data,nowInfo.Data);
         }
         _leftCount.text = GoodsManager.instance.getBagCountByTempId(1,_currentLevel >= 9 ? 208058 : 208036) + "";
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _upBtn1.addEventListener("click",__upBtnHandler1);
         _upBtn2.addEventListener("click",__upBtnHandler2);
         MsgMan.addObserver("MarryEventType.MARRIAGE_DATA",this,__infoUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_upBtn1)
         {
            _upBtn1.removeEventListener("click",__upBtnHandler1);
         }
         if(_upBtn2)
         {
            _upBtn2.removeEventListener("click",__upBtnHandler2);
         }
         MsgMan.removeObserver("MarryEventType.MARRIAGE_DATA",this,__infoUpdateHandler);
      }
      
      private function __infoUpdateHandler(param1:String, param2:Object) : void
      {
         if(_currentLevel != model.marriageData.ringInfo.ringGrade)
         {
            _currentLevel = model.marriageData.ringInfo.ringGrade;
         }
         refreshProgress();
         refreshViewByLevel();
         _leftGoods.text = LanguageMgr.GetTranslation(_currentLevel >= 9 ? "marry.income.MarryRingUpgradeFrame.leftGoods.text1" : "marry.income.MarryRingUpgradeFrame.leftGoods.text");
         var _loc4_:int = _currentLevel >= 9 ? 208058 : 208036;
         var _loc3_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_);
         _propTipsContiner.tipData = _loc3_.Description;
      }
      
      private function __upBtnHandler1(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:String = null;
         var _loc5_:TodayNotAlertFrame = null;
         var _loc6_:String = null;
         var _loc3_:String = null;
         if(nextInfo == null)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("buildings.seminary.view.SeminaryFrameBottomView.isMaxLevelTip"));
            return;
         }
         if(_currentLevel >= 9)
         {
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc4_ = LanguageMgr.GetTranslation("marry.income.MarryRingUpgradeFrame.upbtnAlert02",1,1);
            SharedManagerHelper.ins.needAlert("marry.income.MarryRingUpgradeFrame.upbtnAlert021",checkPointForHeightNormalBack,_loc2_,_loc4_);
         }
         else if(checkIsExpired(SharedManager.instance.upRingNormalAlertDate))
         {
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert");
            _loc6_ = LanguageMgr.GetTranslation("marry.income.MarryRingUpgradeFrame.upbtnAlert01",_needPoint,1);
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc5_.show(_loc6_,_loc3_,checkPointForNormalBack,null,"center",2,true);
         }
         else
         {
            upRingForNormal(SharedManager.instance.upRingNormalUseBind);
         }
      }
      
      private function __upBtnHandler2(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc4_:String = null;
         var _loc5_:TodayNotAlertFrame = null;
         var _loc6_:String = null;
         var _loc3_:String = null;
         if(nextInfo == null)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("buildings.seminary.view.SeminaryFrameBottomView.isMaxLevelTip"));
            return;
         }
         if(_currentLevel >= 9)
         {
            _loc2_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc4_ = LanguageMgr.GetTranslation("marry.income.MarryRingUpgradeFrame.upbtnAlert02",10,10);
            SharedManagerHelper.ins.needAlert("marry.income.MarryRingUpgradeFrame.upbtnAlert022",checkPointForHeightSeniorBack,_loc2_,_loc4_);
         }
         else if(checkIsExpired(SharedManager.instance.upRingSeniorAlertDate))
         {
            _loc5_ = ComponentFactory.Instance.creatComponentByStylename("worldboss.RiverNotAlert");
            _loc6_ = LanguageMgr.GetTranslation("marry.income.MarryRingUpgradeFrame.upbtnAlert01",_needPoint * 50,50);
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc5_.show(_loc6_,_loc3_,checkPointForSeniorBack,null,"center",2,true);
         }
         else
         {
            upRingForSenior(SharedManager.instance.upRingSeniorUseBind);
         }
      }
      
      private function checkPointForHeightSeniorBack() : void
      {
         upRingForHeightSenior();
      }
      
      private function upRingForHeightSenior() : void
      {
         MarrySender.upgradeRing(1,2);
      }
      
      private function checkPointForSeniorBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.upRingSeniorAlertDate = new Date();
            SharedManager.instance.saveupRingSeniorAlertDate();
            SharedManager.instance.upRingSeniorUseBind = param2;
            SharedManager.instance.saveUpRingSeniorUseBind();
         }
         upRingForSenior(param2);
      }
      
      private function upRingForSenior(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         if(GoodsManager.instance.goodsCountByTempId[208036])
         {
            _loc2_ = int(GoodsManager.instance.goodsCountByTempId[208036]);
         }
         var _loc3_:int = 1;
         var _loc4_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         if(param1)
         {
            _loc3_ = 0;
            _loc4_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
         }
         _loc4_ = _loc2_ * _needPoint + _loc4_;
         if(_loc4_ < _needPoint * 50)
         {
            RechargeAlertMannager.show();
            return;
         }
         MarrySender.upgradeRing(_loc3_,2);
      }
      
      private function checkPointForHeightNormalBack() : void
      {
         upRingForHeightNormal();
      }
      
      private function checkPointForNormalBack(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            SharedManager.instance.upRingNormalAlertDate = new Date();
            SharedManager.instance.saveupRingNormalAlertDate();
            SharedManager.instance.upRingNormalUseBind = param2;
            SharedManager.instance.saveUpRingNormalUseBind();
         }
         upRingForNormal(param2);
      }
      
      private function checkIsExpired(param1:Date) : Boolean
      {
         var _loc2_:Date = null;
         var _loc3_:Boolean = true;
         if(param1)
         {
            _loc2_ = new Date();
            if(_loc2_.fullYear == param1.fullYear && _loc2_.month == param1.month && _loc2_.date == param1.date)
            {
               _loc3_ = false;
            }
         }
         return _loc3_;
      }
      
      private function upRingForHeightNormal() : void
      {
         MarrySender.upgradeRing(0,1);
      }
      
      private function upRingForNormal(param1:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         if(GoodsManager.instance.goodsCountByTempId[208036])
         {
            _loc2_ = int(GoodsManager.instance.goodsCountByTempId[208036]);
         }
         if(_loc2_ > 0)
         {
            MarrySender.upgradeRing(0,1);
         }
         else
         {
            _loc3_ = 1;
            _loc4_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
            if(param1)
            {
               _loc3_ = 0;
               _loc4_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
            }
            if(_loc4_ < _needPoint)
            {
               RechargeAlertMannager.show();
               return;
            }
            MarrySender.upgradeRing(_loc3_,1);
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      private function get model() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      private function get nowInfo() : UpgradeTemplateInfo
      {
         var _loc1_:int = int(model.marriageData.ringInfo.ringGrade);
         return TempleteManager.instance.getTemplateByLevelAndType(_loc1_,36);
      }
      
      private function get nextInfo() : UpgradeTemplateInfo
      {
         var _loc1_:int = int(model.marriageData.ringInfo.ringGrade);
         return TempleteManager.instance.getTemplateByLevelAndType(_loc1_ + 1,36);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_killInfoItemNow)
         {
            _killInfoItemNow.dispose();
         }
         _killInfoItemNow = null;
         if(_killInfoItemNext)
         {
            _killInfoItemNext.dispose();
         }
         _killInfoItemNext = null;
         if(_itemList)
         {
            _itemList = null;
         }
         if(_killSprite)
         {
            _killSprite = null;
         }
         if(_upBtn1)
         {
            _upBtn1.dispose();
         }
         _upBtn1 = null;
         if(_upBtn2)
         {
            _upBtn2.dispose();
         }
         _upBtn2 = null;
         if(_bg1)
         {
            _bg1.dispose();
         }
         _bg1 = null;
         if(_bg2)
         {
            _bg2.dispose();
         }
         _bg2 = null;
         if(_item1)
         {
            _item1.dispose();
         }
         _item1 = null;
         if(_item2)
         {
            _item2.dispose();
         }
         _item2 = null;
         if(_level1)
         {
            _level1.dispose();
         }
         _level1 = null;
         if(_level2)
         {
            _level2.dispose();
         }
         _level2 = null;
         if(_nowVbox)
         {
            _nowVbox.dispose();
         }
         _nowVbox = null;
         if(_nextVbox)
         {
            _nextVbox.dispose();
         }
         _nextVbox = null;
         if(_coverImage)
         {
            _coverImage.dispose();
         }
         _coverImage = null;
         if(_progress)
         {
            _progress.dispose();
         }
         _progress = null;
         if(_leftGoods)
         {
            _leftGoods.dispose();
         }
         _leftGoods = null;
         if(_leftCount)
         {
            _leftCount.dispose();
         }
         _leftCount = null;
         if(_bg1Right)
         {
            _bg1Right.dispose();
         }
         _bg1Right = null;
         ObjectUtils.disposeObject(_propTipsContiner);
         _propTipsContiner = null;
         ObjectUtils.disposeObject(_proGap);
         _dic = null;
      }
   }
}

