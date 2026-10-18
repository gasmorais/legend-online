package child.attribute
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import mvc.module.children.ChildSender;
   import mvc.module.children.EnterChildPet;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.VersionSwitch;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.BuyFrameI;
   
   public class ChildUpgradeGrowthView extends Frame
   {
      
      private var _data:ChildData;
      
      private var _bg:MutipleImage;
      
      private var _icon:BaseItemView;
      
      private var _nameTxt:FilterFrameText;
      
      private var _proBg01:Bitmap;
      
      private var _proBg02:Bitmap;
      
      private var _pro:Bitmap;
      
      private var _proMask:Shape;
      
      private var _txt:FilterFrameText;
      
      private var _confitmBtn:IconButton;
      
      private var _headIcon:BaseIconView;
      
      private var _numTitle1:FilterFrameText;
      
      private var _numTitle2:FilterFrameText;
      
      private var _numValue1:FilterFrameText;
      
      private var _numValue2:FilterFrameText;
      
      private var _attBackBg:Bitmap;
      
      private var _att01:Bitmap;
      
      private var _att02:Bitmap;
      
      private var _arrowImg:Bitmap;
      
      private var _maxAttImg:Bitmap;
      
      private var _twoStepImg:Bitmap;
      
      private var _twoStepBtn:IconButton;
      
      private var _attBox01:VBox;
      
      private var _attBox02:VBox;
      
      private var _fightImg:Bitmap;
      
      private var _fightMapData:BitmapData;
      
      private var _numContainer:Sprite;
      
      private var txtValueArr:Array;
      
      public function ChildUpgradeGrowthView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,366,355);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         txtValueArr = LanguageMgr.GetTranslation("child.attribute.ChildUpgradeGrowthView.attName").split("|");
         titleText = LanguageMgr.GetTranslation("promotion");
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildUpgradeGrowthView.bg");
         _icon = ComponentFactory.Instance.creatCustomObject("ChildUpgradeGrowthView.Item");
         _proBg01 = ComponentFactory.Instance.creatBitmap("asset.childUpgradeGrowth.proBg01");
         _proBg02 = ComponentFactory.Instance.creatBitmap("asset.childUpgradeGrowth.proBg02");
         _pro = ComponentFactory.Instance.creatBitmap("asset.childUpgradeGrowth.pro");
         _proMask = new Shape();
         _proMask.x = 188;
         _proMask.y = 28;
         _txt = ComponentFactory.Instance.creatComponentByStylename("asset.childUpgradeGrowth.proTxt");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ChildShowView.nameTxt2");
         _confitmBtn = ComponentFactory.Instance.creatComponentByStylename("ChildUpgradeGrowthView.confitmBtn");
         _headIcon = ComponentFactory.Instance.creatCustomObject("ChildUpgradeGrowthView.headIcon");
         _numTitle1 = ComponentFactory.Instance.creatComponentByStylename("ChildUpgradeGrowthView.numTitle1");
         _numTitle2 = ComponentFactory.Instance.creatComponentByStylename("ChildUpgradeGrowthView.numTitle2");
         _numValue1 = ComponentFactory.Instance.creatComponentByStylename("ChildUpgradeGrowthView.numValue1");
         _numValue2 = ComponentFactory.Instance.creatComponentByStylename("ChildUpgradeGrowthView.numValue2");
         _attBackBg = ComponentFactory.Instance.creatBitmap("asset.child.ChildUpgradeGrowthView.Backbg");
         _att01 = ComponentFactory.Instance.creatBitmap("asset.child.ChildUpgradeGrowthView.attbg01");
         _att02 = ComponentFactory.Instance.creatBitmap("asset.child.ChildUpgradeGrowthView.attbg02");
         _arrowImg = ComponentFactory.Instance.creatBitmap("asset.child.ChildUpgradeGrowthView.arrow");
         _maxAttImg = ComponentFactory.Instance.creatBitmap("asset.child.ChildUpgradeGrowthView.maxAtt");
         _twoStepImg = ComponentFactory.Instance.creatBitmap("asset.ChildNursingSpirit.ns.tip");
         _twoStepBtn = ComponentFactory.Instance.creatComponentByStylename("ChildUpgradeGrowthView.twoStepBtn");
         _fightImg = ComponentFactory.Instance.creatBitmap("asset.child.FightCapacityTxt");
         _fightMapData = ComponentFactory.Instance.creatBitmapData("asset.core.number_img_04");
         _numContainer = new Sprite();
         _numContainer.x = 234;
         _numContainer.y = 317;
         _attBox01 = new VBox();
         _attBox01.x = 31;
         _attBox01.y = 168;
         _attBox02 = new VBox();
         _attBox02.x = 262;
         _attBox02.y = 168;
         addToContent(_bg);
         addToContent(_icon);
         addToContent(_proBg01);
         addToContent(_proBg02);
         addToContent(_pro);
         _pro.mask = _proMask;
         addToContent(_proMask);
         addToContent(_txt);
         addToContent(_confitmBtn);
         addToContent(_headIcon);
         addToContent(_numTitle1);
         addToContent(_numTitle2);
         addToContent(_numValue1);
         addToContent(_numValue2);
         addToContent(_attBackBg);
         addToContent(_att01);
         addToContent(_att02);
         addToContent(_attBackBg);
         addToContent(_att01);
         addToContent(_att02);
         addToContent(_arrowImg);
         addToContent(_maxAttImg);
         if(VersionSwitch.CHILD_STEP_TWO)
         {
            addToContent(_twoStepImg);
            addToContent(_twoStepBtn);
         }
         addToContent(_attBox01);
         addToContent(_attBox02);
         addToContent(_nameTxt);
         addToContent(_fightImg);
         addToContent(_numContainer);
         _twoStepImg.visible = false;
         _twoStepBtn.visible = false;
         var _loc1_:GoodsInfo = new GoodsInfo();
         _loc1_.templateId = 2250001;
         _icon.data = _loc1_;
         _numTitle1.text = LanguageMgr.GetTranslation("child.attribute.ChildUpgradeGrowthView.numTitle1");
         _numTitle2.text = LanguageMgr.GetTranslation("child.attribute.ChildUpgradeGrowthView.numTitle2");
      }
      
      private function refreshView() : void
      {
         var _loc9_:UpgradeTemplateInfo = null;
         var _loc6_:int = 0;
         var _loc3_:String = null;
         var _loc14_:ChildTempInfo = null;
         var _loc7_:FilterFrameText = null;
         var _loc8_:FilterFrameText = null;
         _attBox01.disposeAllChildren();
         _attBox02.disposeAllChildren();
         _nameTxt.text = _data.name;
         NumberViewUtils.refreshValue(_data.fightValue,_numContainer,_fightMapData,19,25,15,19,"0123456789");
         if(_data.isNursingSpirit)
         {
            _loc9_ = TempleteManager.instance.getTemplateByLevelAndType(_data.growthGrade + 1,128);
         }
         else
         {
            _loc9_ = TempleteManager.instance.getTemplateByLevelAndType(_data.growthGrade + 1,44);
         }
         _twoStepImg.visible = false;
         _twoStepBtn.visible = false;
         var _loc10_:int = int(thane.attackProrerty.totalPhyAttack);
         if(_loc10_ < thane.attackProrerty.totalMagicAttack)
         {
            _loc10_ = int(thane.attackProrerty.totalMagicAttack);
         }
         var _loc12_:EnterChildPet = _data.enterPet;
         var _loc5_:int = int(_loc12_ ? _loc12_.Live : 0);
         var _loc2_:int = int(_loc12_ ? _loc12_.Attack : 0);
         var _loc11_:int = int(_loc12_ ? _loc12_.Defence : 0);
         var _loc13_:int = int(_loc12_ ? _loc12_.MagicAttack : 0);
         var _loc1_:int = int(_loc12_ ? _loc12_.MagicDefence : 0);
         _loc6_ = 0;
         while(_loc6_ < 5)
         {
            _loc3_ = txtValueArr[_loc6_];
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("childAdv.NewGrowthTxt");
            if(_data.growthGrade < 12)
            {
               _loc14_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_data.job,_data.growthGrade + 1);
               _loc8_ = ComponentFactory.Instance.creatComponentByStylename("childAdv.NewGrowthTxt");
               _loc8_.setFrame(_data.growthGrade + 1);
               switch(_loc6_)
               {
                  case 0:
                     _loc3_ += _loc14_.Live + "%(" + (int(thane.attackProrerty.totalLive * _loc14_.Live / 100 + getExtarAdd(_loc6_))) + ")";
                     break;
                  case 1:
                     _loc3_ += _loc14_.Attack + "%(" + (int(_loc10_ * _loc14_.Attack / 100 + getExtarAdd(_loc6_))) + ")";
                     break;
                  case 2:
                     _loc3_ += _loc14_.Defence + "%(" + (int(thane.attackProrerty.totalPhyDefence * _loc14_.Defence / 100 + getExtarAdd(_loc6_))) + ")";
                     break;
                  case 3:
                     _loc3_ += _loc14_.MagicAttack + "%(" + (int(_loc10_ * _loc14_.MagicAttack / 100 + getExtarAdd(_loc6_))) + ")";
                     break;
                  case 4:
                     _loc3_ += _loc14_.MagicDefence + "%(" + (int(thane.attackProrerty.totalMagicDefence * _loc14_.MagicDefence / 100 + getExtarAdd(_loc6_))) + ")";
               }
               _loc8_.text = _loc3_;
               _attBox02.addChild(_loc8_);
               _maxAttImg.visible = false;
            }
            else
            {
               if(_maxAttImg && !_maxAttImg.visible)
               {
                  _maxAttImg.visible = true;
               }
               if(_data.isNursingSpirit)
               {
                  _twoStepImg.visible = true;
                  _twoStepBtn.visible = true;
               }
               _attBox02.visible = false;
            }
            _loc7_.setFrame(_data.growthGrade);
            _loc14_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_data.job,_data.growthGrade);
            _loc3_ = txtValueArr[_loc6_];
            switch(_loc6_)
            {
               case 0:
                  _loc3_ += _loc14_.Live + "%(" + _data.childAttInfo.hp + ")";
                  break;
               case 1:
                  _loc3_ += _loc14_.Attack + "%(" + _data.childAttInfo.attack + ")";
                  break;
               case 2:
                  _loc3_ += _loc14_.Defence + "%(" + _data.childAttInfo.defence + ")";
                  break;
               case 3:
                  _loc3_ += _loc14_.MagicAttack + "%(" + _data.childAttInfo.magicAttack + ")";
                  break;
               case 4:
                  _loc3_ += _loc14_.MagicDefence + "%(" + _data.childAttInfo.magicDefence + ")";
            }
            _loc7_.text = _loc3_;
            _attBox01.addChild(_loc7_);
            _loc6_++;
         }
         var _loc4_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_data.job,_data.growthGrade);
         _headIcon.icon = PathManager.info.ResourcePath + "icon" + _loc4_.Icon;
         if(_loc9_)
         {
            _txt.text = _data.growthGp + "/" + _loc9_.Data;
            _confitmBtn.enable = true;
            if(_data.growthGp > _loc9_.Data)
            {
               _data.growthGp = _loc9_.Data;
            }
            if(_data.growthGp < 0)
            {
               _data.growthGp = 0;
            }
            drawMask(_data.growthGp,_loc9_.Data);
         }
         else
         {
            _confitmBtn.enable = false;
            if(_data.isNursingSpirit)
            {
               _loc9_ = TempleteManager.instance.getTemplateByLevelAndType(_data.growthGrade,128);
            }
            else
            {
               _loc9_ = TempleteManager.instance.getTemplateByLevelAndType(_data.growthGrade,44);
            }
            _txt.text = _loc9_.Data + "/" + _loc9_.Data;
            drawMask(_loc9_.Data,_loc9_.Data);
         }
         if(GoodsManager.instance.getBagCountByTempId(1,2250001) <= 0)
         {
            _numValue1.text = "0";
            _numValue2.text = "1";
            _confitmBtn.enable = true;
            return;
         }
         _numValue1.text = GoodsManager.instance.getBagCountByTempId(1,2250001) + "";
         _numValue2.text = _numValue1.text;
      }
      
      private function getExtarAdd(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc4_:ChildTempInfo = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(_data.job,_data.growthGrade);
         var _loc2_:int = int(thane.attackProrerty.totalPhyAttack);
         if(_loc2_ < thane.attackProrerty.totalMagicAttack)
         {
            _loc2_ = int(thane.attackProrerty.totalMagicAttack);
         }
         switch(param1)
         {
            case 0:
               _loc3_ = _data.childAttInfo.hp - int(thane.attackProrerty.totalLive * _loc4_.Live / 100);
               break;
            case 1:
               _loc3_ = _data.childAttInfo.attack - int(_loc2_ * _loc4_.Attack / 100);
               break;
            case 2:
               _loc3_ = _data.childAttInfo.defence - int(thane.attackProrerty.totalPhyDefence * _loc4_.Defence / 100);
               break;
            case 3:
               _loc3_ = _data.childAttInfo.magicAttack - int(_loc2_ * _loc4_.MagicAttack / 100);
               break;
            case 4:
               _loc3_ = _data.childAttInfo.magicDefence - int(thane.attackProrerty.totalMagicDefence * _loc4_.MagicDefence / 100);
         }
         return _loc3_;
      }
      
      public function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         if(_numValue2)
         {
            _numValue2.addEventListener("change",__txtChangeHandler);
         }
         if(_confitmBtn)
         {
            _confitmBtn.addEventListener("click",__upgradeHandler);
         }
         _twoStepBtn.addEventListener("click",twoStepClickHandler);
         MsgMan.addObserver("ChildEvent.CHILD_INFO",this,__childInfoChildHandler);
         MsgMan.addObserver("ChildEvent.CHILD_DELETE",this,__deleteChildHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_numValue2)
         {
            _numValue2.removeEventListener("change",__txtChangeHandler);
         }
         if(_confitmBtn)
         {
            _confitmBtn.removeEventListener("click",__upgradeHandler);
         }
         _twoStepBtn.removeEventListener("click",twoStepClickHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_INFO",this,__childInfoChildHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_DELETE",this,__deleteChildHandler);
      }
      
      private function twoStepClickHandler(param1:MouseEvent) : void
      {
         ChildSender.nsTrainOp(44,_data.childId);
         dispose();
      }
      
      private function __deleteChildHandler(param1:String, param2:Object) : void
      {
         var _loc3_:ChildData = param2 as ChildData;
         if(_data == null || _loc3_.childId == _data.childId)
         {
            dispose();
         }
      }
      
      private function __childInfoChildHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __upgradeHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(_numValue2)
         {
            _loc2_ = int(GoodsManager.instance.getBagCountByTempId(1,2250001));
            _loc3_ = parseInt(_numValue2.text);
            if(_loc2_ < _loc3_)
            {
               showQutiBuy(2250001,_loc3_ - _loc2_,_loc3_);
            }
            else if(_data.isNursingSpirit)
            {
               ChildSender.nsUpGrowthValue(29,_data.childId,_loc3_);
            }
            else
            {
               ChildSender.upGrowthValue(_data.childId,_loc3_);
            }
         }
      }
      
      private function __txtChangeHandler(param1:Event) : void
      {
         var _loc2_:int = int(GoodsManager.instance.getBagCountByTempId(1,2250001));
         var _loc3_:int = parseInt(_numValue2.text);
         if(_loc3_ <= 0)
         {
            _loc3_ = 1;
         }
         _numValue2.text = _loc3_ + "";
      }
      
      private function showQutiBuy(param1:int, param2:int, param3:int) : void
      {
         var temapleteId:int = param1;
         var count:int = param2;
         var totalCount:int = param3;
         var quickUIcallback:Function = function():void
         {
            var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
            var _loc2_:ShopGoodsInfo = TempleteManager.instance.getShopInfoByItemIdAndArea(temapleteId,10);
            _loc1_.data(_loc2_,count,totalCount);
            _loc1_.callback = buyCallBack;
            _loc1_.show();
         };
         CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
      }
      
      private function buyCallBack(param1:Boolean, param2:Object = null) : void
      {
         if(!param1)
         {
            return;
         }
         _numValue1.text = GoodsManager.instance.getBagCountByTempId(1,2250001) + "";
         _numValue2.text = _numValue1.text;
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function set data(param1:ChildData) : void
      {
         if(param1 == null)
         {
            dispose();
            return;
         }
         _data = param1;
         refreshView();
      }
      
      private function drawMask(param1:int, param2:int) : void
      {
         _proMask.graphics.clear();
         _proMask.graphics.beginFill(0,0);
         _proMask.graphics.drawRect(0,0,223 * param1 / param2,16);
         _proMask.graphics.endFill();
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         if(param1)
         {
            data = param1.frameData as ChildData;
         }
      }
      
      private function unInitView() : void
      {
         _data = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_proBg01);
         _proBg01 = null;
         ObjectUtils.disposeObject(_proBg02);
         _proBg02 = null;
         ObjectUtils.disposeObject(_pro);
         _pro = null;
         ObjectUtils.disposeObject(_proMask);
         _proMask = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_confitmBtn);
         _confitmBtn = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(_numTitle1);
         _numTitle1 = null;
         ObjectUtils.disposeObject(_numTitle2);
         _numTitle2 = null;
         ObjectUtils.disposeObject(_numValue1);
         _numValue1 = null;
         ObjectUtils.disposeObject(_numValue2);
         _numValue2 = null;
         ObjectUtils.disposeObject(_attBackBg);
         _attBackBg = null;
         ObjectUtils.disposeObject(_att01);
         _att01 = null;
         ObjectUtils.disposeObject(_att02);
         _att02 = null;
         ObjectUtils.disposeObject(_arrowImg);
         _arrowImg = null;
         ObjectUtils.disposeObject(_maxAttImg);
         _maxAttImg = null;
         ObjectUtils.disposeObject(_twoStepImg);
         _twoStepImg = null;
         ObjectUtils.disposeObject(_twoStepBtn);
         _twoStepBtn = null;
         ObjectUtils.disposeObject(_attBox01);
         _attBox01 = null;
         ObjectUtils.disposeObject(_attBox02);
         _attBox02 = null;
         ObjectUtils.disposeObject(_fightImg);
         _fightImg = null;
         ObjectUtils.disposeObject(_fightMapData);
         _fightMapData = null;
         ObjectUtils.disposeObject(_numContainer);
         _numContainer = null;
         txtValueArr = null;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}

