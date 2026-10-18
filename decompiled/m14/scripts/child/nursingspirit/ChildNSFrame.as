package child.nursingspirit
{
   import child.attribute.ChildAttriTwoStepView;
   import child.attribute.ChildNsProItem;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.ModuleFrameInfo;
   import mvc.module.avenger.AvengerChildNsInfo;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildSender;
   import mvc.module.theseus.AttributeUtils;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   import yishi.view.base.NumberBitmap;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class ChildNSFrame extends Frame
   {
      
      private var _bgImg:MutipleImage;
      
      private var _progressBarImg:ScaleFrameImage;
      
      private var _mainAttView:ChildAttriTwoStepView;
      
      private var _upGradeBtn:IconButton;
      
      private var _upGradeImage:Image;
      
      private var _upGradeTxt:FilterFrameText;
      
      private var _addPtBtn:IconButton;
      
      private var _addPtImage:Image;
      
      private var _addPtTxt:FilterFrameText;
      
      private var _adPtNeedNum:int;
      
      private var _adPtHasMtNum:int;
      
      private var _adPtNeedMinGrade:int;
      
      private var _boxList:Vector.<ChildNsFMSkillIconView> = new Vector.<ChildNsFMSkillIconView>();
      
      private const BOX_POS:Array = [[358,97],[435,98],[514,99],[391,163],[476,164]];
      
      private var _headIcon:BaseIconView;
      
      private var _headNameTxt:FilterFrameText;
      
      private var _helpImage:Image;
      
      private var _addProMcList:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      private var _proItemList:Vector.<ChildNsProItem> = new Vector.<ChildNsProItem>();
      
      private var _proCenterImg:ScaleFrameImage;
      
      private var _gradeCon:NumberBitmap;
      
      private var _stepNameTxt:FilterFrameText;
      
      private var _allPointTxt:FilterFrameText;
      
      private var _resultDic:SimpleDictionary = new SimpleDictionary();
      
      private var _centerContainer:Sprite;
      
      private var _data:ChildData;
      
      private var _reduceIds:Array = [];
      
      private var _prePropAry:Array = [0,0,0,0];
      
      public function ChildNSFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:ChildNsFMSkillIconView = null;
         var _loc1_:ChildNsProItem = null;
         var _loc3_:MovieClip = null;
         var _loc4_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("child_deamage_reduction");
         if(_loc4_)
         {
            _reduceIds = _loc4_.ConfigValue.split(",");
            _reduceIds.unshift(0);
         }
         _bgImg = ComponentFactory.Instance.creatComponentByStylename("ui.childnursingspirit.nsbg");
         _progressBarImg = ComponentFactory.Instance.creatComponentByStylename("ui.childnursingspirit.nscolorLine");
         _mainAttView = ComponentFactory.Instance.creatCustomObject("ChildNursingSpirit.nsAtt.main");
         _stepNameTxt = ComponentFactory.Instance.creatComponentByStylename("ChildNSFrame.stepNameTxt");
         _allPointTxt = ComponentFactory.Instance.creatComponentByStylename("ChildNSFrame.allPointTxt");
         _headIcon = ComponentFactory.Instance.creatCustomObject("ChildNSFrame.childIcon");
         _headNameTxt = ComponentFactory.Instance.creatComponentByStylename("ChildNSFrame.childIconNameTxt");
         _upGradeBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpirit.ns.upGradeBtn");
         _upGradeImage = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpirit.ns.upGradeImage");
         _upGradeTxt = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpirit.ns.upGradetText");
         _addPtBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpirit.ns.addPtBtn");
         _addPtImage = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpirit.ns.addPtImage");
         _addPtTxt = ComponentFactory.Instance.creatComponentByStylename("ChildNursingSpirit.ns.addPtText");
         _proCenterImg = ComponentFactory.Instance.creatComponentByStylename("ui.childnursingspirit.ns.centerBtn");
         _helpImage = ComponentFactory.Instance.creatComponentByStylename("childnsframe.helpImage");
         _helpImage.tipData = LanguageMgr.GetTranslation("childnsframe.helpContext");
         _gradeCon = new NumberBitmap();
         _gradeCon.initParams("asset.ChildNursingSpirit.ns.lvImage","asset.AvengerChildNsSwordView.numBit",14,22,11,14,"0123456789",26);
         _centerContainer = new Sprite();
         addToContent(_bgImg);
         addToContent(_centerContainer);
         addToContent(_mainAttView);
         addToContent(_stepNameTxt);
         addToContent(_allPointTxt);
         addToContent(_headIcon);
         addToContent(_headNameTxt);
         _centerContainer.addChild(_progressBarImg);
         _centerContainer.addChild(_upGradeBtn);
         _centerContainer.addChild(_upGradeImage);
         _centerContainer.addChild(_upGradeTxt);
         _centerContainer.addChild(_addPtBtn);
         _centerContainer.addChild(_addPtImage);
         _centerContainer.addChild(_addPtTxt);
         _centerContainer.addChild(_proCenterImg);
         _centerContainer.addChild(_gradeCon);
         _centerContainer.addChild(_helpImage);
         var _loc6_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < 5)
         {
            _loc2_ = new ChildNsFMSkillIconView(_loc6_ + 1);
            _loc2_.x = BOX_POS[_loc6_][0];
            _loc2_.y = BOX_POS[_loc6_][1];
            _centerContainer.addChild(_loc2_);
            _boxList[_loc6_] = _loc2_;
            _loc6_++;
         }
         _loc6_ = 1;
         while(_loc6_ <= 4)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("ChildNsProItem.propItem" + _loc6_,[1,_loc6_]);
            _centerContainer.addChild(_loc1_);
            _proItemList[_loc6_ - 1] = _loc1_;
            _loc3_ = ComponentFactory.Instance.creatCustomObject("ChildNsProItem.addMc" + _loc6_);
            _centerContainer.addChild(_loc3_);
            _loc3_.gotoAndStop(28);
            _addProMcList[_loc6_ - 1] = _loc3_;
            _loc6_++;
         }
         _headNameTxt.setFrame(2);
         _progressBarImg.setFrame(1);
         _proCenterImg.setFrame(1);
         _proCenterImg.buttonMode = true;
         _gradeCon.x = 447;
         _gradeCon.y = 338;
         _centerContainer.x = -102;
         _centerContainer.y = 3;
         _gradeCon.num = 0;
         var _loc5_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208526);
         if(_loc5_)
         {
            _upGradeImage.tipData = _loc5_.TemplateName + "\n" + _loc5_.Description;
         }
         _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(208527);
         if(_loc5_)
         {
            _addPtImage.tipData = _loc5_.TemplateName + "\n" + _loc5_.Description;
         }
         initUpgradeDic();
      }
      
      public function initUpgradeDic() : void
      {
         var _loc2_:UpgradeTemplateInfo = null;
         var _loc3_:int = 0;
         var _loc1_:Array = TempleteManager.instance.getTemplatesByType(157);
         _loc1_.sortOn("Grades",16);
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc3_];
            if(!_resultDic.hasOwnProperty(_loc2_.ActiveObject))
            {
               _resultDic.add(_loc2_.ActiveObject,_loc2_.Grades);
            }
            _loc3_++;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bgImg);
         _bgImg = null;
         ObjectUtils.disposeObject(_progressBarImg);
         _progressBarImg = null;
         ObjectUtils.disposeObject(_mainAttView);
         _mainAttView = null;
         ObjectUtils.disposeObject(_stepNameTxt);
         _stepNameTxt = null;
         ObjectUtils.disposeObject(_allPointTxt);
         _allPointTxt = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(_headNameTxt);
         _headNameTxt = null;
         ObjectUtils.disposeObject(_upGradeBtn);
         _upGradeBtn = null;
         ObjectUtils.disposeObject(_upGradeImage);
         _upGradeImage = null;
         ObjectUtils.disposeObject(_upGradeTxt);
         _upGradeTxt = null;
         ObjectUtils.disposeObject(_addPtBtn);
         _addPtBtn = null;
         ObjectUtils.disposeObject(_addPtImage);
         _addPtImage = null;
         ObjectUtils.disposeObject(_addPtTxt);
         _addPtTxt = null;
         ObjectUtils.disposeObject(_proCenterImg);
         _proCenterImg = null;
         ObjectUtils.disposeObject(_gradeCon);
         _gradeCon = null;
         ObjectUtils.disposeObject(_helpImage);
         _helpImage = null;
         LogicUtils.disposeDisplayCollection(_boxList);
         _boxList = null;
         LogicUtils.disposeDisplayCollection(_proItemList);
         _proItemList = null;
         LogicUtils.disposeDisplayCollection(_addProMcList);
         _addProMcList = null;
         super.dispose();
         if(_resultDic)
         {
            _resultDic.clear();
         }
         _resultDic = null;
         _data = null;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _upGradeBtn.addEventListener("click",upGradeClickHandler);
         _addPtBtn.addEventListener("click",addPtClickHandler);
         _proCenterImg.addEventListener("click",addPtClickHandler);
         MsgMan.addObserver("ChildEvent.CHILD_NSINFO_UPDATE",this,__childInfoHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _upGradeBtn.removeEventListener("click",upGradeClickHandler);
         _addPtBtn.removeEventListener("click",addPtClickHandler);
         _proCenterImg.removeEventListener("click",addPtClickHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_NSINFO_UPDATE",this,__childInfoHandler);
      }
      
      private function __childInfoHandler(param1:String, param2:Object) : void
      {
         refreshView(true);
      }
      
      private function upGradeClickHandler(param1:MouseEvent) : void
      {
         ChildSender.nsTrainOp(45,_data.childId);
      }
      
      private function addPtClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_adPtHasMtNum < _adPtNeedNum)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("PetHallowsRightSkillView.train.noGoodsAlert"));
            return;
         }
         var _loc2_:Boolean = _data.nursingSpiritInfo.trainInfo.liveGrade >= _adPtNeedMinGrade;
         _loc2_ &&= _data.nursingSpiritInfo.trainInfo.defenseGrade >= _adPtNeedMinGrade;
         _loc2_ &&= _data.nursingSpiritInfo.trainInfo.attackGrade >= _adPtNeedMinGrade;
         _loc2_ &&= _data.nursingSpiritInfo.trainInfo.magicDefenseGrade >= _adPtNeedMinGrade;
         if(!_loc2_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("ChildNSFrame.needPropGrade.alert",_adPtNeedMinGrade));
            return;
         }
         ChildSender.nsTrainOp(46,_data.childId);
      }
      
      private function refreshView(param1:Boolean = false) : void
      {
         var _loc6_:int = 0;
         var _loc8_:Array = null;
         var _loc9_:Array = null;
         var _loc12_:AvengerChildNsInfo = _data.nursingSpiritInfo.trainInfo;
         if(param1)
         {
            _loc6_ = 0;
            _loc8_ = [_loc12_.liveGrade,_loc12_.defenseGrade,_loc12_.attackGrade,_loc12_.magicDefenseGrade];
            _loc9_ = [1500,200,200,200];
            _loc6_ = 0;
            while(_loc6_ < 4)
            {
               if(_loc8_[_loc6_] - _prePropAry[_loc6_] != 0)
               {
                  playMovie(_addProMcList[_loc6_],_loc9_[_loc6_]);
               }
               _loc6_++;
            }
         }
         _prePropAry = [_loc12_.liveGrade,_loc12_.defenseGrade,_loc12_.attackGrade,_loc12_.magicDefenseGrade];
         _headIcon.icon = PathManager.info.ResourcePath + "icon" + _loc12_.childTemp.Icon;
         _headNameTxt.text = _loc12_.childTemp.JobName;
         var _loc5_:int = _loc12_.profileGrade + 1;
         _stepNameTxt.text = LanguageMgr.GetTranslation("yishi.utils.GoodsHelp.getGoodQualityName0" + _loc5_) + LanguageMgr.GetTranslation("mounts.command01",_loc12_.stageGrade - _resultDic[_loc5_ - 1] + 1);
         _progressBarImg.setFrame(_loc5_);
         _proCenterImg.setFrame(_loc5_);
         _gradeCon.num = _loc12_.grade;
         _allPointTxt.text = "" + _loc12_.point;
         _mainAttView.data = _loc12_;
         _mainAttView.updateReduce(int(_reduceIds[_loc5_ - 1]));
         var _loc4_:int = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(208526));
         var _loc3_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc12_.grade + 1,156);
         if(_loc3_)
         {
            _upGradeBtn.enable = true;
            _upGradeTxt.text = _loc4_ + "/" + _loc3_.Data;
            if(_loc4_ < _loc3_.Data)
            {
               _upGradeBtn.enable = false;
               _upGradeTxt.htmlText = AttributeUtils.getColorStr("" + _loc4_,"#ff3300") + "/" + _loc3_.Data;
            }
         }
         else
         {
            _upGradeBtn.enable = false;
            _upGradeTxt.text = _loc4_ + "/0";
         }
         _loc4_ = int(GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(208527));
         _loc3_ = TempleteManager.instance.getTemplateByLevelAndType(_loc12_.stageGrade + 1,157);
         if(_loc3_)
         {
            _adPtNeedNum = _loc3_.Data;
            _adPtHasMtNum = _loc4_;
            _adPtNeedMinGrade = int(_loc3_.TemplateName.split(",")[1]);
            _addPtBtn.enable = true;
            _addPtTxt.text = _loc4_ + "/" + _loc3_.Data;
            if(_loc4_ < _loc3_.Data)
            {
               _addPtBtn.enable = false;
               _addPtTxt.htmlText = AttributeUtils.getColorStr("" + _loc4_,"#ff3300") + "/" + _loc3_.Data;
            }
         }
         else
         {
            _addPtBtn.enable = false;
            _addPtTxt.text = _loc4_ + "/0";
            _adPtNeedMinGrade = 0;
         }
         for each(var _loc2_:ChildNsProItem in _proItemList)
         {
            _loc2_.data = _loc12_;
         }
         var _loc10_:Array = [1,1,1,1,1];
         var _loc11_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc12_.grade,156);
         if(_loc11_)
         {
            _loc10_ = _loc11_.TemplateName.split(",");
         }
         for each(var _loc7_:ChildNsFMSkillIconView in _boxList)
         {
            _loc7_.updateBuffGradeMax(_loc10_);
            _loc7_.chData = _data;
         }
      }
      
      private function playMovie(param1:MovieClip, param2:int) : void
      {
         if(!param1)
         {
            return;
         }
         param1.gotoAndPlay(1);
         var _loc4_:MovieClip = param1["newMc"] as MovieClip;
         var _loc3_:MovieClip = param1["oldMc"] as MovieClip;
         _loc3_.visible = false;
         _loc3_["valueTxt"]["text"] = "";
         _loc4_.gotoAndStop(1);
         _loc4_["valueTxt"]["text"] = param2 + "";
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         this.titleText = LanguageMgr.GetTranslation("ChildNSFrame.title");
         _data = param1.frameData as ChildData;
         if(_data)
         {
            refreshView();
         }
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
   }
}

