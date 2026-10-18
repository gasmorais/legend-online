package child.nursingspirit
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.children.ChildNursingSpiritModel;
   import mvc.module.children.ChildSender;
   import mvc.module.shop.ShopGoodsInfo;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseItemView;
   import yishi.view.community.BulePowerItem;
   import yishi.view.frame.BuyFrameI;
   
   public class ChildNsEmblemResiUpFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _lvIcon:Image;
      
      private var _lvTxt:FilterFrameText;
      
      private var _exp:BulePowerItem;
      
      private var _item:BaseItemView;
      
      private var _currentTxt:FilterFrameText;
      
      private var _costTxt:FilterFrameText;
      
      private var _inputBack:Image;
      
      private var _inputTxt:FilterFrameText;
      
      private var _alertTxt:FilterFrameText;
      
      private var _upContiner:Component;
      
      private var _textBack:ScaleBitmapImage;
      
      private var _arrowImage:Image;
      
      private var _maxLevelBmp:Image;
      
      private var _vBox1:VBox;
      
      private var _vBox2:VBox;
      
      private var _vBox3:VBox;
      
      private var _vBox4:VBox;
      
      private var _vBox5:VBox;
      
      private var _vBox6:VBox;
      
      private var curTxtList:Vector.<FilterFrameText>;
      
      private var newTxtList:Vector.<FilterFrameText>;
      
      private var addTxtList:Vector.<FilterFrameText>;
      
      private var _upBtn:IconButton;
      
      private var attNameList0:Array;
      
      private var attNameList1:Array;
      
      private var attNameList2:Array;
      
      private var bitmapStrArr:Array;
      
      private var heightArr:Array;
      
      private var textBackArr:Array;
      
      private var upTypesArr:Array;
      
      private var clickIndex:int;
      
      private var curUpgradeTemp:UpgradeTemplateInfo;
      
      private var nextUpgradeTemp:UpgradeTemplateInfo;
      
      private var needTempId:int;
      
      private var noQutiBuyList:Array = [212002,212003,212004];
      
      public function ChildNsEmblemResiUpFrame()
      {
         super();
         initShowData();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initShowData() : void
      {
         heightArr = [520,415,325];
         textBackArr = [238,125,35];
         upTypesArr = [129,130,131];
         attNameList0 = ["Attack","Defence","MagicAttack","MagicDefence","ForceHit","Penetrate","Parry","Live","StunAttr"];
         attNameList1 = ["FireResi","WaterResi","WindResi","ElectResi","LightResi","DarkResi"];
         attNameList2 = ["ReduceResi"];
         bitmapStrArr = ["asset.child.ChildAttributeViewII.imageTxt","asset.ChildEmblemRightView.Img","asset.ChildEmblemRightView.Img"];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ChildNsEmblemResiUpFrame.bg");
         _lvIcon = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpView.lvIcon");
         _lvTxt = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpView.levelTxt");
         _exp = ComponentFactory.Instance.creatCustomObject("ChildEmblemUpView.LevelExp",[true]);
         _item = ComponentFactory.Instance.creatCustomObject("ChildEmblemUpView.item");
         _currentTxt = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpView.currentTxt");
         _costTxt = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpView.costTxt");
         _inputBack = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpView.inputBack");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpView.inputTxt");
         _alertTxt = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpView.alertTxt");
         _textBack = ComponentFactory.Instance.creatComponentByStylename("ChildNsEmblemResiUpFrame.textBack");
         _arrowImage = ComponentFactory.Instance.creatComponentByStylename("ChildNsEmblemResiUpFrame.arrowImage");
         _maxLevelBmp = ComponentFactory.Instance.creatComponentByStylename("ChildNsEmblemResiUpFrame.maxLevelBmp");
         _vBox1 = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpGradeFrame.vBox1");
         _vBox2 = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpGradeFrame.vBox2");
         _vBox3 = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpGradeFrame.vBox3");
         _vBox4 = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpGradeFrame.vBox4");
         _vBox5 = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpGradeFrame.vBox5");
         _vBox6 = ComponentFactory.Instance.creatComponentByStylename("ChildEmblemUpGradeFrame.vBox6");
         _upBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNsEmblemResiUpFrame.upBtn");
         _upContiner = new Component();
         addToContent(_bg);
         addToContent(_upContiner);
         _upContiner.x = 90;
         addToContent(_textBack);
         addToContent(_arrowImage);
         addToContent(_vBox1);
         addToContent(_vBox2);
         addToContent(_vBox3);
         addToContent(_vBox4);
         addToContent(_vBox5);
         addToContent(_vBox6);
         addToContent(_maxLevelBmp);
         addToContent(_upBtn);
         _upContiner.addChild(_lvIcon);
         _upContiner.addChild(_lvTxt);
         _upContiner.addChild(_exp);
         _upContiner.addChild(_item);
         _upContiner.addChild(_currentTxt);
         _upContiner.addChild(_costTxt);
         _upContiner.addChild(_inputBack);
         _upContiner.addChild(_inputTxt);
         _upContiner.addChild(_alertTxt);
         _costTxt.text = LanguageMgr.GetTranslation("child.attribute.ChildUpgradeGrowthView.numTitle2");
      }
      
      private function addImageAndTxt() : void
      {
         var _loc4_:int = 0;
         var _loc3_:Bitmap = null;
         var _loc1_:FilterFrameText = null;
         curTxtList = new Vector.<FilterFrameText>();
         newTxtList = new Vector.<FilterFrameText>();
         addTxtList = new Vector.<FilterFrameText>();
         var _loc5_:Array = this["attNameList" + clickIndex];
         var _loc2_:int = int(_loc5_.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = ComponentFactory.Instance.creatBitmap(getLinkStr(_loc4_));
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.txt");
            _vBox1.addChild(_loc3_);
            _vBox2.addChild(_loc1_);
            _loc1_.setFrame(1);
            curTxtList.push(_loc1_);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = ComponentFactory.Instance.creatBitmap(getLinkStr(_loc4_));
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.txt");
            _vBox3.addChild(_loc3_);
            _vBox4.addChild(_loc1_);
            _loc1_.setFrame(2);
            newTxtList.push(_loc1_);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = ComponentFactory.Instance.creatBitmap("asset.ChildEmblemUpGradeFrame.upImage");
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("ChildAttributeViewII.txt");
            _vBox5.addChild(_loc3_);
            _vBox6.addChild(_loc1_);
            _loc1_.setFrame(2);
            addTxtList.push(_loc1_);
            _loc4_++;
         }
      }
      
      private function getLinkStr(param1:int) : String
      {
         var _loc3_:int = 0;
         var _loc2_:String = bitmapStrArr[clickIndex];
         if(clickIndex == 0)
         {
            _loc3_ = param1 + 4;
         }
         else if(clickIndex == 1)
         {
            _loc3_ = param1 + 1;
         }
         else if(clickIndex == 2)
         {
            _loc3_ = param1;
         }
         else
         {
            _loc3_ = 0;
         }
         return _loc2_ + _loc3_;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         if(_upBtn)
         {
            _upBtn.addEventListener("click",__upBtnHandler);
         }
         if(_inputTxt)
         {
            _inputTxt.addEventListener("change",__txtChangeHandler);
         }
         MsgMan.addObserver("ChildEvent.CHILD_INFO",this,__childInfoHandler);
         MsgMan.addObserver("ChildEvent.CHILD_NSINFO_UPDATE",this,__childInfoHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_upBtn)
         {
            _upBtn.removeEventListener("click",__upBtnHandler);
         }
         if(_inputTxt)
         {
            _inputTxt.removeEventListener("change",__txtChangeHandler);
         }
         MsgMan.removeObserver("ChildEvent.CHILD_INFO",this,__childInfoHandler);
         MsgMan.removeObserver("ChildEvent.CHILD_NSINFO_UPDATE",this,__childInfoHandler);
      }
      
      private function __childInfoHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __txtChangeHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(isDie == false)
         {
            _loc2_ = int(GoodsManager.instance.getBagCountByTempId(1,needTempId));
            _loc4_ = parseInt(_inputTxt.text);
            if(noQutiBuyList.indexOf(needTempId) < 0)
            {
               _inputTxt.text = _loc4_ + "";
            }
            else
            {
               _loc3_ = parseInt(_inputTxt.text);
               if(_loc3_ <= 0)
               {
                  _inputTxt.text = "1";
               }
               if(_loc3_ >= _loc4_)
               {
                  _inputTxt.text = _loc4_ + "";
               }
            }
         }
      }
      
      private function __upBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = clickIndex + 30;
         var _loc3_:int = parseInt(_inputTxt.text);
         var _loc4_:int = int(GoodsManager.instance.getBagCountByTempId(1,needTempId));
         if(_loc4_ < _loc3_)
         {
            showQutiBuy(needTempId,_loc3_ - _loc4_);
         }
         else
         {
            ChildSender.nsUpGrowthValue(_loc2_,nsModel.selectedNsChild.childId,_loc3_);
         }
      }
      
      private function showQutiBuy(param1:int, param2:int) : void
      {
         var temapleteId:int = param1;
         var count:int = param2;
         var quickUIcallback:Function = function():void
         {
            var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
            var _loc2_:ShopGoodsInfo = TempleteManager.instance.getShopInfoByItemIdAndArea(temapleteId,10);
            _loc1_.data(_loc2_,count);
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
         var _loc3_:int = int(GoodsManager.instance.getBagCountByTempId(1,needTempId));
         _currentTxt.text = LanguageMgr.GetTranslation("ChildNsEmblemResiUpFrame.currentTxt.hasCount",_loc3_);
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SkillPropertyTempInfo = null;
         var _loc4_:SkillPropertyTempInfo = null;
         curUpgradeTemp = TempleteManager.instance.getTemplateByLevelAndType(curGrade,upTypesArr[clickIndex]);
         nextUpgradeTemp = TempleteManager.instance.getTemplateByLevelAndType(curGrade + 1,upTypesArr[clickIndex]);
         if(nsModel.selectedNsChild == null || curUpgradeTemp == null)
         {
            dispose();
            return;
         }
         if(clickIndex == 0)
         {
            _loc1_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(curUpgradeTemp.ActiveObject);
            if(nextUpgradeTemp)
            {
               _loc4_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(nextUpgradeTemp.ActiveObject);
            }
         }
         if(!nextUpgradeTemp)
         {
            _vBox3.visible = _vBox4.visible = _vBox5.visible = _vBox6.visible = false;
            _alertTxt.text = LanguageMgr.GetTranslation("child.emblem.ChildEmblemUpView.alertTxt3");
            _upBtn.enable = false;
            _exp.full = true;
            _maxLevelBmp.visible = true;
            needTempId = curUpgradeTemp.TemplateId;
         }
         else
         {
            _vBox3.visible = _vBox4.visible = _vBox5.visible = _vBox6.visible = true;
            _upBtn.enable = true;
            _exp.max = nextUpgradeTemp.Data;
            _exp.current = curGp;
            _maxLevelBmp.visible = false;
            needTempId = nextUpgradeTemp.TemplateId;
         }
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = needTempId;
         _item.data = _loc3_;
         _lvTxt.text = curGrade + "";
         var _loc5_:int = int(GoodsManager.instance.getBagCountByTempId(1,needTempId));
         _currentTxt.text = LanguageMgr.GetTranslation("ChildNsEmblemResiUpFrame.currentTxt.hasCount",_loc5_);
         _inputTxt.text = _loc5_ + "";
         if(_loc5_ <= 0)
         {
            if(noQutiBuyList.indexOf(needTempId) >= 0)
            {
               _upBtn.enable = false;
            }
            else
            {
               _inputTxt.text = "1";
               _upBtn.enable = true;
            }
         }
         if(clickIndex == 0)
         {
            _loc2_ = 0;
            while(_loc2_ < curTxtList.length)
            {
               curTxtList[_loc2_].text = _loc1_[attNameList0[_loc2_]] + "";
               _loc2_++;
            }
            if(nextUpgradeTemp)
            {
               _loc2_ = 0;
               while(_loc2_ < newTxtList.length)
               {
                  newTxtList[_loc2_].text = _loc4_[attNameList0[_loc2_]] + "";
                  _loc2_++;
               }
               _loc2_ = 0;
               while(_loc2_ < addTxtList.length)
               {
                  addTxtList[_loc2_].text = _loc4_[attNameList0[_loc2_]] - _loc1_[attNameList0[_loc2_]] + "";
                  _loc2_++;
               }
            }
         }
         else
         {
            _loc2_ = 0;
            while(_loc2_ < curTxtList.length)
            {
               curTxtList[_loc2_].text = curUpgradeTemp.ActiveObject + "";
               _loc2_++;
            }
            if(nextUpgradeTemp)
            {
               _loc2_ = 0;
               while(_loc2_ < newTxtList.length)
               {
                  newTxtList[_loc2_].text = nextUpgradeTemp.ActiveObject + "";
                  _loc2_++;
               }
               _loc2_ = 0;
               while(_loc2_ < addTxtList.length)
               {
                  addTxtList[_loc2_].text = nextUpgradeTemp.ActiveObject - curUpgradeTemp.ActiveObject + "";
                  _loc2_++;
               }
            }
         }
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
      
      private function get curGrade() : int
      {
         if(clickIndex == 0)
         {
            return nsModel.selectedNsChild.emblemLv;
         }
         if(clickIndex == 1)
         {
            return nsModel.selectedNsChild.nursingSpiritInfo.resiGrade;
         }
         if(clickIndex == 2)
         {
            return nsModel.selectedNsChild.nursingSpiritInfo.reduceResiGrade;
         }
         return 0;
      }
      
      private function get curGp() : int
      {
         if(clickIndex == 0)
         {
            return nsModel.selectedNsChild.emblemGp;
         }
         if(clickIndex == 1)
         {
            return nsModel.selectedNsChild.nursingSpiritInfo.resiGp;
         }
         if(clickIndex == 2)
         {
            return nsModel.selectedNsChild.nursingSpiritInfo.reduceResiGp;
         }
         return 0;
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         if(param1 && param1.frameData)
         {
            clickIndex = int(param1.frameData) - 1;
         }
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         this.titleText = LanguageMgr.GetTranslation("ChildNsEmblemResiUpFrame.title.text" + clickIndex);
         this.height = heightArr[clickIndex];
         addImageAndTxt();
         _textBack.height = textBackArr[clickIndex];
         _bg.height = this.height - 80;
         if(clickIndex != 2)
         {
            _arrowImage.y = _maxLevelBmp.y = _textBack.y + _textBack.height / 2;
         }
         else
         {
            _arrowImage.y = _maxLevelBmp.y = _textBack.y + 5;
         }
         _upBtn.y = _textBack.y + _textBack.height + 10;
         refreshView();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_lvIcon)
         {
            ObjectUtils.disposeObject(_lvIcon);
         }
         _lvIcon = null;
         if(_lvTxt)
         {
            ObjectUtils.disposeObject(_lvTxt);
         }
         _lvTxt = null;
         if(_item)
         {
            ObjectUtils.disposeObject(_item);
         }
         _item = null;
         if(_exp)
         {
            ObjectUtils.disposeObject(_exp);
         }
         _exp = null;
         if(_currentTxt)
         {
            ObjectUtils.disposeObject(_currentTxt);
         }
         _currentTxt = null;
         if(_costTxt)
         {
            ObjectUtils.disposeObject(_costTxt);
         }
         _costTxt = null;
         if(_inputBack)
         {
            ObjectUtils.disposeObject(_inputBack);
         }
         _inputBack = null;
         if(_inputTxt)
         {
            ObjectUtils.disposeObject(_inputTxt);
         }
         _inputTxt = null;
         if(_alertTxt)
         {
            ObjectUtils.disposeObject(_alertTxt);
         }
         _alertTxt = null;
         if(_textBack)
         {
            ObjectUtils.disposeObject(_textBack);
         }
         _textBack = null;
         if(_arrowImage)
         {
            ObjectUtils.disposeObject(_arrowImage);
         }
         _arrowImage = null;
         if(_upBtn)
         {
            ObjectUtils.disposeObject(_upBtn);
         }
         _upBtn = null;
         if(_upContiner)
         {
            ObjectUtils.disposeObject(_upContiner);
         }
         _upContiner = null;
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
         if(_vBox3)
         {
            ObjectUtils.disposeObject(_vBox3);
         }
         _vBox3 = null;
         if(_vBox4)
         {
            ObjectUtils.disposeObject(_vBox4);
         }
         _vBox4 = null;
         if(_vBox5)
         {
            ObjectUtils.disposeObject(_vBox5);
         }
         _vBox5 = null;
         if(_vBox6)
         {
            ObjectUtils.disposeObject(_vBox6);
         }
         _vBox6 = null;
         LogicUtils.disposeDisplayCollection(curTxtList);
         curTxtList = null;
         LogicUtils.disposeDisplayCollection(newTxtList);
         newTxtList = null;
         LogicUtils.disposeDisplayCollection(addTxtList);
         addTxtList = null;
         attNameList0 = null;
         attNameList1 = null;
         attNameList2 = null;
         heightArr = null;
         textBackArr = null;
         upTypesArr = null;
         super.dispose();
      }
   }
}

