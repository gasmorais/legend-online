package child.nursingspirit
{
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildNursingSpiritModel;
   import mvc.module.children.ChildSender;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.GoodsManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.StringHelper;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildNSMostConversionInfoView extends Component
   {
      
      private var _bg:Image;
      
      private var _spliteImage:ScaleBitmapImage;
      
      private var _nameTxt:FilterFrameText;
      
      private var _chargeNeedCountTxt:FilterFrameText;
      
      private var _refreshNeedCountTxt:FilterFrameText;
      
      private var _chargeImage:Image;
      
      private var _refreshImage:Image;
      
      private var _helpBtn:BaseButton;
      
      private var _showContainer:Sprite;
      
      private var _equipBtn:IconButton;
      
      private var _unInstallBtn:IconButton;
      
      private var _chargeBtn:IconButton;
      
      private var _refreshBtn:IconButton;
      
      private var _progressBg:Image;
      
      private var _progressTxtBg:Image;
      
      private var _hbox:HBox;
      
      private var _mask:Shape;
      
      private var _txtList:Vector.<Component>;
      
      private var _vBox1:VBox;
      
      private var _vBox2:VBox;
      
      private var _conversionPreTxt:FilterFrameText;
      
      private var _data:ChildData;
      
      private var _chargeGoodsTemplateInfo:GoodsTemplateInfo;
      
      private var _refreshGoodsTemplateInfo:GoodsTemplateInfo;
      
      private var _chargeNeedCount:int;
      
      private var _refreshNeedCount:int;
      
      private var _currentGrade:int;
      
      private var _chargeGoodsTotalCount:int;
      
      private var _refreshGoodsTotalCount:int;
      
      private var _filter:UIFilter;
      
      private var _strip:StripView;
      
      public function ChildNSMostConversionInfoView()
      {
         super();
         initView();
         initEvent();
         initVBox1Txt();
         initHboxData();
         mouseEnabled = false;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostInfoView.bg");
         _spliteImage = ComponentFactory.Instance.creatComponentByStylename("child.spliteImage");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostInfoView.nameTxt");
         _chargeNeedCountTxt = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostInfoView.chargeNeedCountTxt");
         _refreshNeedCountTxt = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostInfoView.refreshNeedCountTxt");
         _equipBtn = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostInfoView.equipBtn");
         _unInstallBtn = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostInfoView.unInstallBtn");
         _chargeBtn = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostInfoView.chargeBtn");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostInfoView.refreshBtn");
         _chargeImage = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostInfoView.chargeImage");
         _refreshImage = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostInfoView.refreshImage");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostInfoView.helpBtn");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostInfoView.hbox");
         _progressBg = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostInfoView.progressBg");
         _progressTxtBg = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostInfoView.progressTxtBg");
         _vBox1 = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostInfoView.vBox1");
         _vBox2 = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostInfoView.vBox2");
         _conversionPreTxt = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostInfoView.conversionPreTxt");
         _strip = ComponentFactory.Instance.creatCustomObject("childTreasureMostView.StripView");
         _filter = new UIFilter();
         _showContainer = new Sprite();
         _showContainer.mouseChildren = _showContainer.mouseEnabled = false;
         _mask = new Shape();
         _mask.graphics.beginFill(16777215,0);
         _mask.graphics.drawRect(0,0,_progressTxtBg.width,_progressTxtBg.height);
         _mask.graphics.endFill();
         _mask.x = _progressTxtBg.x - _progressTxtBg.width;
         _mask.y = _progressTxtBg.y;
         _progressTxtBg.mask = _mask;
         addChild(_bg);
         addChild(_spliteImage);
         addChild(_showContainer);
         addChild(_nameTxt);
         addChild(_chargeNeedCountTxt);
         addChild(_refreshNeedCountTxt);
         addChild(_equipBtn);
         addChild(_unInstallBtn);
         addChild(_chargeBtn);
         addChild(_refreshBtn);
         addChild(_chargeImage);
         addChild(_refreshImage);
         addChild(_progressBg);
         addChild(_progressTxtBg);
         addChild(_helpBtn);
         addChild(_hbox);
         addChild(_mask);
         addChild(_vBox1);
         addChild(_vBox2);
         addChild(_strip);
         _strip.addChild(_conversionPreTxt);
         _chargeGoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208201);
         if(_chargeGoodsTemplateInfo)
         {
            _chargeImage.tipData = _chargeGoodsTemplateInfo.TemplateName + ":" + _chargeGoodsTemplateInfo.Description;
         }
         _refreshGoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208202);
         if(_refreshGoodsTemplateInfo)
         {
            _refreshImage.tipData = _refreshGoodsTemplateInfo.TemplateName + ":" + _refreshGoodsTemplateInfo.Description;
         }
         var _loc1_:Array = ConfigInfoManager.instance.getNsTreasureMostRefreshCount();
         if(_loc1_)
         {
            _refreshNeedCount = _loc1_[5];
         }
      }
      
      private function unInitView() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_spliteImage)
         {
            ObjectUtils.disposeObject(_spliteImage);
         }
         _spliteImage = null;
         if(_nameTxt)
         {
            ObjectUtils.disposeObject(_nameTxt);
         }
         _nameTxt = null;
         if(_equipBtn)
         {
            ObjectUtils.disposeObject(_equipBtn);
         }
         _equipBtn = null;
         if(_unInstallBtn)
         {
            ObjectUtils.disposeObject(_unInstallBtn);
         }
         _unInstallBtn = null;
         if(_chargeBtn)
         {
            ObjectUtils.disposeObject(_chargeBtn);
         }
         _chargeBtn = null;
         if(_refreshBtn)
         {
            ObjectUtils.disposeObject(_refreshBtn);
         }
         _refreshBtn = null;
         if(_chargeNeedCountTxt)
         {
            ObjectUtils.disposeObject(_chargeNeedCountTxt);
         }
         _chargeNeedCountTxt = null;
         if(_refreshNeedCountTxt)
         {
            ObjectUtils.disposeObject(_refreshNeedCountTxt);
         }
         _refreshNeedCountTxt = null;
         if(_chargeImage)
         {
            ObjectUtils.disposeObject(_chargeImage);
         }
         _chargeImage = null;
         if(_refreshImage)
         {
            ObjectUtils.disposeObject(_refreshImage);
         }
         _refreshImage = null;
         if(_helpBtn)
         {
            ObjectUtils.disposeObject(_helpBtn);
         }
         _helpBtn = null;
         if(_progressBg)
         {
            ObjectUtils.disposeObject(_progressBg);
         }
         _progressBg = null;
         if(_progressTxtBg)
         {
            ObjectUtils.disposeObject(_progressTxtBg);
         }
         _progressTxtBg = null;
         if(_vBox1)
         {
            ObjectUtils.disposeObject(_vBox1);
         }
         _vBox1 = null;
         if(_vBox2)
         {
            ObjectUtils.disposeObject(_vBox2);
         }
         _vBox2 = null;
         if(_conversionPreTxt)
         {
            ObjectUtils.disposeObject(_conversionPreTxt);
         }
         _conversionPreTxt = null;
         if(_hbox)
         {
            ObjectUtils.disposeObject(_hbox);
         }
         _hbox = null;
         if(_showContainer)
         {
            ObjectUtils.disposeObject(_showContainer);
         }
         _showContainer = null;
         if(_mask)
         {
            ObjectUtils.disposeObject(_mask);
         }
         _mask = null;
      }
      
      private function initEvent() : void
      {
         _helpBtn.addEventListener("click",__helpBtnHandler);
         _equipBtn.addEventListener("click",__equipBtnHandler);
         _unInstallBtn.addEventListener("click",__unInstallBtnHandler);
         _chargeBtn.addEventListener("click",__chargeBtnHandler);
         _refreshBtn.addEventListener("click",__refreshBtnHandler);
      }
      
      private function removeEvent() : void
      {
         _helpBtn.removeEventListener("click",__helpBtnHandler);
         _equipBtn.removeEventListener("click",__equipBtnHandler);
         _unInstallBtn.removeEventListener("click",__unInstallBtnHandler);
         _chargeBtn.removeEventListener("click",__chargeBtnHandler);
         _refreshBtn.removeEventListener("click",__refreshBtnHandler);
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("childMostConversionInfoView.helpFrame");
         _loc2_.show();
      }
      
      private function __equipBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         ChildSender.nsTreasureMostEquip(nsModel.selectedNsChild.childId);
      }
      
      private function __unInstallBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         ChildSender.nsTreasureMostEquip(nsModel.selectedNsChild.childId);
      }
      
      private function __chargeBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(nextUpgradeTemplateInfo)
         {
            if(_chargeGoodsTotalCount < _chargeNeedCount)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.HolyDragonSoulView.Tips01"));
               return;
            }
            ChildSender.nsTreasureMostCharge(nsModel.selectedNsChild.childId);
            return;
         }
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("child.nursingspirit.ChildNSMostConversionInfoView.Max"));
      }
      
      private function __refreshBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_refreshGoodsTotalCount < _refreshNeedCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.holydragonsoul.HolyDragonSoulView.Tips01"));
            return;
         }
         ChildSender.nsTreasureMostRefresh(nsModel.selectedNsChild.childId);
      }
      
      private function initVBox1Txt() : void
      {
         var _loc1_:FilterFrameText = null;
         var _loc3_:Component = null;
         var _loc4_:int = 0;
         var _loc2_:Array = ["pet.fireRes","pet.waterRes","pet.electRes","pet.windRes","pet.darkRes","pet.lightRes"];
         _txtList = new Vector.<Component>();
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _loc3_ = new Component();
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostInfoView.txt");
            _loc1_.text = LanguageMgr.GetTranslation(_loc2_[_loc4_]);
            _loc3_.addChild(_loc1_);
            _loc3_.tipStyle = "yishi.view.tips.OneLineTip";
            _loc3_.tipDirctions = "7,5,4,6";
            _loc3_.tipGapH = 30;
            _loc3_.isFollowMouse = false;
            _txtList.push(_loc3_);
            _vBox1.addChild(_loc3_);
            _loc4_++;
         }
      }
      
      private function initHboxData() : void
      {
         var _loc1_:ChildNSTreasureMostEquipItem = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new ChildNSTreasureMostEquipItem();
            _loc1_.index = _loc2_;
            _hbox.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function refreshView() : void
      {
         if(nsModel.selectedNsChildTemp)
         {
            _nameTxt.text = nsModel.selectedNsChildTemp.ArtifactName;
            if(nsModel.selectedNsChild.nursingSpiritInfo.spiritArtifactInfo.isEquip)
            {
               _unInstallBtn.visible = true;
               _equipBtn.visible = false;
               _filter.setNormalFilter(_strip);
            }
            else
            {
               _unInstallBtn.visible = false;
               _equipBtn.visible = true;
               _filter.setGrayFilter(_strip);
            }
            _conversionPreTxt.text = grade + "%";
            _mask.x = _progressTxtBg.x - _progressTxtBg.width + int(grade * 5.1);
            _chargeGoodsTotalCount = GoodsManager.instance.getGoodsNumByTempId(208201);
            _refreshGoodsTotalCount = GoodsManager.instance.getGoodsNumByTempId(208202);
            if(nextUpgradeTemplateInfo)
            {
               _chargeNeedCount = nextUpgradeTemplateInfo.Data;
               _chargeNeedCountTxt.text = _chargeGoodsTotalCount + "/" + _chargeNeedCount;
            }
            else
            {
               _chargeNeedCountTxt.text = "Max";
            }
            _refreshNeedCountTxt.text = _refreshGoodsTotalCount + "/" + _refreshNeedCount;
            refreshVbox1Data();
            refreshVbox2Data();
            refreshHboxData();
         }
      }
      
      private function refreshHboxData() : void
      {
         var _loc3_:ChildNSTreasureMostEquipItem = null;
         var _loc7_:Array = null;
         var _loc1_:Array = null;
         var _loc5_:int = 0;
         var _loc2_:Array = null;
         var _loc4_:SkillTempInfo = null;
         var _loc8_:int = 0;
         var _loc6_:String = nsModel.selectedNsChild.fightSkill;
         var _loc9_:String = nsModel.selectedNsChild.nursingSpiritInfo.spiritArtifactInfo.enchants;
         if(_loc9_)
         {
            _loc7_ = _loc9_.split(",");
         }
         if(_loc6_)
         {
            _loc1_ = _loc6_.split(",");
         }
         _loc5_ = 0;
         while(_loc5_ < 5)
         {
            _loc3_ = _hbox.getChildAt(_loc5_) as ChildNSTreasureMostEquipItem;
            _loc3_.isActive = (_loc5_ + 1) * 20 <= nsModel.selectedNsChild.nursingSpiritInfo.spiritArtifactInfo.progress ? true : false;
            if(_loc7_)
            {
               _loc3_.type = _loc7_[_loc5_];
            }
            if(_loc1_ && _loc1_[_loc5_] && _loc1_[_loc5_] != "-1")
            {
               _loc2_ = nsModel.selectedNsChild.skill.split(",");
               _loc8_ = 0;
               while(_loc8_ < _loc2_.length)
               {
                  if(_loc2_[_loc8_] && parseInt(_loc2_[_loc8_]) > 0)
                  {
                     if(TempleteManager.instance.getSkillById(_loc2_[_loc8_]).SonType == _loc1_[_loc5_])
                     {
                        _loc4_ = TempleteManager.instance.getSkillById(_loc2_[_loc8_]);
                     }
                  }
                  _loc8_++;
               }
               _loc3_.data = _loc4_;
            }
            else
            {
               _loc3_.data = null;
            }
            _loc5_++;
         }
      }
      
      private function refreshVbox1Data() : void
      {
         var _loc1_:Component = null;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = _txtList[_loc2_] as Component;
            if(_loc1_)
            {
               if(_data.nursingSpiritInfo.spiritArtifactInfo.isEquip)
               {
                  _loc1_.tipData = getTipData(getOldValueArr()[_loc2_],_data.childAttInfo.resiArr[_loc2_ + 1],_loc1_);
               }
               else
               {
                  _loc1_.tipData = getTipData(_data.childAttInfo.resiArr[_loc2_ + 1],_data.childAttInfo.resiArr[_loc2_ + 1],_loc1_);
               }
            }
            _loc2_++;
         }
      }
      
      private function getOldValueArr() : Array
      {
         var _loc2_:Array = null;
         var _loc1_:String = _data.nursingSpiritInfo.spiritArtifactInfo.resis;
         if(!StringHelper.isNullOrEmpty(_loc1_))
         {
            _loc2_ = _loc1_.split(",");
         }
         return _loc2_;
      }
      
      private function getTipData(param1:Number, param2:Number, param3:Component) : String
      {
         return getTipString(param1,param2 - param1,param3);
      }
      
      private function getTipString(param1:int, param2:int, param3:Component) : String
      {
         var _loc8_:String = null;
         var _loc5_:FilterFrameText = null;
         var _loc9_:String = "";
         var _loc4_:String = "";
         var _loc7_:String = LanguageMgr.GetTranslation("public.upArrow");
         var _loc10_:String = LanguageMgr.GetTranslation("public.downArrow");
         var _loc6_:String = LanguageMgr.GetTranslation("childNs.addUpArrow");
         var _loc11_:String = LanguageMgr.GetTranslation("childNs.addDownArrow");
         if(param2 > 0)
         {
            _loc8_ = "#59cd41";
            _loc9_ = "+" + param2;
            _loc5_ = param3.getChildAt(0) as FilterFrameText;
            if(_loc5_)
            {
               _loc4_ = _loc5_.htmlText;
               if(_loc4_.indexOf(_loc7_) == -1)
               {
                  _loc4_ = _loc4_.replace(_loc11_,"");
                  _loc5_.htmlText = _loc4_ + _loc6_;
               }
            }
         }
         else if(param2 < 0)
         {
            _loc8_ = "#FF0000";
            _loc9_ = "" + param2;
            _loc5_ = param3.getChildAt(0) as FilterFrameText;
            if(_loc5_)
            {
               _loc4_ = _loc5_.htmlText;
               if(_loc4_.indexOf(_loc10_) == -1)
               {
                  _loc4_ = _loc4_.replace(_loc6_,"");
                  _loc5_.htmlText = _loc4_ + _loc11_;
               }
            }
         }
         else
         {
            _loc8_ = "#FFFFFF";
            _loc9_ = "";
            _loc5_ = param3.getChildAt(0) as FilterFrameText;
            if(_loc5_)
            {
               _loc4_ = _loc5_.htmlText;
               _loc4_ = _loc4_.replace(_loc6_,"");
               _loc4_ = _loc4_.replace(_loc11_,"");
               _loc5_.htmlText = _loc4_;
            }
         }
         _loc9_ = StringHelper.format("<font face=\'Arial\' color=\'{0}\'>{1}</font>",_loc8_,_loc9_);
         if(param1 < 0)
         {
            _loc8_ = "#FF0000";
         }
         else
         {
            _loc8_ = "#FFFFFF";
         }
         var _loc12_:String = StringHelper.format("<font face=\'Arial\' color=\'{0}\'>{1}</font>",_loc8_,param1);
         return _loc12_ + _loc9_;
      }
      
      private function refreshVbox2Data() : void
      {
         var _loc2_:FilterFrameText = null;
         var _loc3_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         _vBox2.removeAllChild();
         var _loc1_:String = nsModel.selectedNsChild.nursingSpiritInfo.spiritArtifactInfo.resiTypes;
         if(!StringHelper.isNullOrEmpty(_loc1_))
         {
            _loc3_ = _loc1_.split(",");
         }
         var _loc4_:Array = ["pet.fireRes","pet.waterRes","pet.electRes","pet.windRes","pet.darkRes","pet.lightRes"];
         _loc5_ = 0;
         while(_loc5_ < 6)
         {
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("childTreasureMostInfoView.txt");
            if(_loc3_)
            {
               _loc6_ = int(_loc3_[_loc5_]);
               _loc2_.text = LanguageMgr.GetTranslation(_loc4_[_loc6_]);
            }
            _vBox2.addChild(_loc2_);
            _loc5_++;
         }
      }
      
      private function startLoader(param1:ChildTempInfo) : void
      {
         if(!param1)
         {
            return;
         }
         var _loc2_:String = PathManager.getTreasureMostShowPath(param1.ArtifactPath);
         LoaderManagerII.instance.load(_loc2_,2,8,__loadMorphAvatarCompleteHandler);
      }
      
      private function __loadMorphAvatarCompleteHandler(param1:LoaderInfo, param2:Object) : void
      {
         var _loc4_:DisplayObject = null;
         if(isDie)
         {
            return;
         }
         while(_showContainer.numChildren > 0)
         {
            _loc4_ = _showContainer.getChildAt(0);
            _showContainer.removeChild(_loc4_);
         }
         var _loc3_:MovieClip = param2 as MovieClip;
         if(_loc3_)
         {
            if(_showContainer)
            {
               if(nsModel.selectedNsChildTemp.JobType == 101)
               {
                  _loc3_.x = -200;
                  _loc3_.y = -135;
               }
               else if(nsModel.selectedNsChildTemp.JobType == 102)
               {
                  _loc3_.x = -220;
                  _loc3_.y = -135;
               }
               else if(nsModel.selectedNsChildTemp.JobType == 103 || nsModel.selectedNsChildTemp.JobType == 105)
               {
                  _loc3_.x = -220;
                  _loc3_.y = -125;
               }
               else if(nsModel.selectedNsChildTemp.JobType == 104)
               {
                  _loc3_.x = 0;
                  _loc3_.y = -60;
               }
               _showContainer.addChild(_loc3_);
            }
            _loc3_.mouseChildren = _loc3_.mouseEnabled = false;
         }
      }
      
      public function set data(param1:ChildData) : void
      {
         if(param1 == null)
         {
            return;
         }
         _data = param1;
         startLoader(_data.childTempInfo);
         refreshView();
      }
      
      private function get nextUpgradeTemplateInfo() : UpgradeTemplateInfo
      {
         return TempleteManager.instance.getTemplateByLevelAndType(grade + 1,154);
      }
      
      private function get currentUpgradeTemplateInfo() : UpgradeTemplateInfo
      {
         return TempleteManager.instance.getTemplateByLevelAndType(grade,154);
      }
      
      private function get grade() : int
      {
         return nsModel.selectedNsChild.nursingSpiritInfo.spiritArtifactInfo.progress;
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}

