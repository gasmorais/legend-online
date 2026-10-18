package fashion
{
   import bag.events.BagEvent;
   import bag.helper.GoodsCheck;
   import battle.utils.Helpers;
   import cell.view.fashionbag.FashionBagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.fashion.FashionInfoMsg;
   import events.FashionEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import mainBar.StripView;
   import mainBar.effects.MainToolBtnGlowEffect;
   import managers.StoreSocketOutManager;
   import mvc.module.fashion.FashionModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleDictionary;
   
   public class FashionComposeView extends Sprite implements Disposeable
   {
      
      private var _back:MovieClip;
      
      private var _composeBtn:IconButton;
      
      private var _fashion1:FashionBagCell;
      
      private var _fashion2:FashionBagCell;
      
      private var _fashion3:FashionBagCell;
      
      private var _fashion4:FashionBagCell;
      
      private var _fashionDic:SimpleDictionary;
      
      private var _cell1:FashionBagCell;
      
      private var _itemDic:SimpleDictionary;
      
      private var _progressBg:Bitmap;
      
      private var _progressGreen:MovieClip;
      
      private var _progressBlue:MovieClip;
      
      private var _progressTxt:FilterFrameText;
      
      private var _progressAddTxt:FilterFrameText;
      
      private var _levelBmp:Bitmap;
      
      private var _levelTxt:FilterFrameText;
      
      private var _resultMask:MovieClip;
      
      private var _filter:ColorMatrixFilter = UIFilter.getGrayFilter();
      
      private var _progressStrip:StripView;
      
      private var _composeResultNew:MovieClip;
      
      private var _colorManager:MainToolBtnGlowEffect;
      
      private var _composeNewPos:Array = [-13,57,120,183];
      
      private var _composeOldIds:SimpleDictionary;
      
      private var _reduceBtn:BaseButton;
      
      private var _addBtn:BaseButton;
      
      private var _minBtn:BaseButton;
      
      private var _maxBtn:BaseButton;
      
      private var _numBg:Image;
      
      private var _composeNumTxt:FilterFrameText;
      
      private var _count:int;
      
      private var _isDie:Boolean;
      
      public function FashionComposeView()
      {
         super();
         initView();
         initData();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc3_:Object = null;
         _back = ComponentFactory.Instance.creat("asset.fashionComposeView.back");
         _back.gotoAndStop(1);
         _back["grow1"].gotoAndStop(1);
         _back["grow2"].gotoAndStop(1);
         _back["grow1"].visible = false;
         _back["grow2"].visible = false;
         _back.mouseEnabled = false;
         _loc2_ = 0;
         while(_loc2_ < _back.numChildren)
         {
            _loc3_ = _back.getChildAt(_loc2_);
            if(_loc3_ != _back["result"])
            {
               if(_loc3_.hasOwnProperty("mouseEnabled"))
               {
                  _loc3_.mouseEnabled = false;
               }
            }
            _loc2_++;
         }
         _composeBtn = ComponentFactory.Instance.creatComponentByStylename("fashionComposeView.composeBtn");
         _fashion1 = ComponentFactory.Instance.creatCustomObject("fashion.composeCell1");
         _fashion2 = ComponentFactory.Instance.creatCustomObject("fashion.composeCell1");
         _fashion3 = ComponentFactory.Instance.creatCustomObject("fashion.composeCell1");
         _fashion4 = ComponentFactory.Instance.creatCustomObject("fashion.composeCell1");
         _cell1 = ComponentFactory.Instance.creatCustomObject("fashion.compose.resultCell");
         _progressBg = ComponentFactory.Instance.creatBitmap("asset.fashion.ProgressBarBg");
         _progressGreen = ComponentFactory.Instance.creatCustomObject("fashion.ProgressGreenBar");
         _progressBlue = ComponentFactory.Instance.creatCustomObject("fashion.ProgressBlueBar");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("fashion.ProgressBarTxt");
         _progressAddTxt = ComponentFactory.Instance.creatComponentByStylename("fashion.ProgressBarAddTxt");
         _levelBmp = ComponentFactory.Instance.creatBitmap("asset.fashion.levelBmp");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("fashion.ProgressLevelTxt");
         _progressStrip = ComponentFactory.Instance.creatCustomObject("fashion.fashionProgressStrip");
         _composeResultNew = ComponentFactory.Instance.creatCustomObject("fashion.composeResultNew");
         _numBg = ComponentFactory.Instance.creatComponentByStylename("fashion.ComposeNumBg");
         _composeNumTxt = ComponentFactory.Instance.creatComponentByStylename("fashion.ComposeGoodsNumTxt");
         _reduceBtn = ComponentFactory.Instance.creatComponentByStylename("fashion.PrePageBtn");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("fashion.NextPageBtn");
         _minBtn = ComponentFactory.Instance.creatComponentByStylename("fashion.MinPageBtn");
         _maxBtn = ComponentFactory.Instance.creatComponentByStylename("fashion.MaxPageBtn");
         _resultMask = ComponentFactory.Instance.creat("asset.fashion.GoodsBagBorder2");
         _resultMask.mouseEnabled = false;
         addChild(_back);
         addChild(_progressBg);
         addChild(_progressBlue);
         addChild(_progressGreen);
         addChild(_progressTxt);
         addChild(_progressAddTxt);
         addChild(_levelBmp);
         addChild(_levelTxt);
         addChild(_progressStrip);
         addChild(_numBg);
         addChild(_composeNumTxt);
         addChild(_reduceBtn);
         addChild(_addBtn);
         addChild(_minBtn);
         addChild(_maxBtn);
         addChild(_composeBtn);
         _back["bag1"].addChild(_fashion1);
         _back["bag2"].addChild(_fashion2);
         _back["bag3"].addChild(_fashion3);
         _back["bag4"].addChild(_fashion4);
         _back["result"].addChild(_cell1);
         _cell1.pos = 0;
         _back["result"].addChild(_resultMask);
         var _loc1_:StripView = new StripView();
         _loc1_.setHitArea(0,0,60,60);
         fashionModel.opState = 0;
         _progressGreen.gotoAndStop(1);
         _progressBlue.gotoAndStop(1);
         _progressStrip.setHitArea(0,0,320,20);
         _composeResultNew.gotoAndStop(1);
         _cell1.addChildAt(_loc1_,0);
      }
      
      private function initEvent() : void
      {
         if(_composeBtn)
         {
            _composeBtn.addEventListener("click",__composeHandler);
         }
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4487,__onComposeCallback);
         NotificationManager.instance.addEventListener("FASHION_SHOW_CHANGE",__refreshHandler);
         if(model)
         {
            model.addEventListener("RESET_MOVIECLIP",__resetMovieclipHandler);
         }
         _reduceBtn.addEventListener("click",__onBtnClickHandler);
         _addBtn.addEventListener("click",__onBtnClickHandler);
         _minBtn.addEventListener("click",__onBtnClickHandler);
         _maxBtn.addEventListener("click",__onBtnClickHandler);
         _composeNumTxt.addEventListener("change",__onNumTxtChange);
         __refreshHandler(null);
      }
      
      private function removeEvent() : void
      {
         if(_composeBtn)
         {
            _composeBtn.removeEventListener("click",__composeHandler);
         }
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4487,__onComposeCallback);
         NotificationManager.instance.removeEventListener("FASHION_SHOW_CHANGE",__refreshHandler);
         if(_back)
         {
            _back.removeEventListener("enterFrame",__enterFrameHandler);
         }
         if(model)
         {
            model.removeEventListener("RESET_MOVIECLIP",__resetMovieclipHandler);
         }
         _reduceBtn.removeEventListener("click",__onBtnClickHandler);
         _addBtn.removeEventListener("click",__onBtnClickHandler);
         _minBtn.removeEventListener("click",__onBtnClickHandler);
         _maxBtn.removeEventListener("click",__onBtnClickHandler);
         _composeNumTxt.removeEventListener("change",__onNumTxtChange);
      }
      
      private function initData() : void
      {
         _itemDic = new SimpleDictionary();
         _itemDic.add("0_0_0",_cell1);
         _fashionDic = new SimpleDictionary();
         _fashionDic.add("8_" + thane.id + "_" + 4,_fashion1);
         _fashionDic.add("9_" + thane.id + "_" + 4,_fashion2);
         _fashionDic.add("10_" + thane.id + "_" + 4,_fashion3);
         _fashionDic.add("11_" + thane.id + "_" + 4,_fashion4);
         _composeOldIds = new SimpleDictionary();
         _composeOldIds.add(8,0);
         _composeOldIds.add(9,0);
         _composeOldIds.add(10,0);
         _composeOldIds.add(11,0);
         updateView();
      }
      
      private function __onBtnClickHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         switch(param1.currentTarget)
         {
            case _minBtn:
               _count = 1;
               break;
            case _reduceBtn:
               _count = _count - 1;
               break;
            case _addBtn:
               _count = _count + 1;
               break;
            case _maxBtn:
               _count = _cell1.data.count;
         }
         if(_count <= 1)
         {
            _count = 1;
         }
         else if(_count >= _cell1.data.count)
         {
            _count = _cell1.data.count;
         }
         _composeNumTxt.text = _count + "";
         updateView(true);
      }
      
      private function __onNumTxtChange(param1:Event) : void
      {
         _count = int(_composeNumTxt.text);
         if(_count <= 1)
         {
            _count = 1;
         }
         else if(_count >= _cell1.data.count)
         {
            _count = _cell1.data.count;
         }
         _composeNumTxt.text = _count + "";
         updateView(true);
      }
      
      private function __composeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         doCompose();
      }
      
      private function doCompose() : void
      {
         if(_isDie)
         {
            return;
         }
         if(!_itemDic)
         {
            return;
         }
         var _loc1_:GoodsInfo = _cell1.data as GoodsInfo;
         if(_loc1_ == null)
         {
            return;
         }
         if(_composeBtn)
         {
            _composeBtn.enable = false;
         }
         composeStart();
      }
      
      private function composeStart() : void
      {
         if(_back)
         {
            _back.gotoAndPlay(1);
            _back["grow1"].visible = _back["grow2"].visible = true;
            _back["grow1"].gotoAndPlay(1);
            _back["grow2"].gotoAndPlay(1);
            _back.addEventListener("enterFrame",__enterFrameHandler);
            model.opState = 1;
         }
      }
      
      private function __enterFrameHandler(param1:Event) : void
      {
         if(_back["iconentermc"])
         {
            if(_back["iconentermc"]["icon"])
            {
               if(_cell1)
               {
                  _back["iconentermc"]["icon"].addChild(_cell1);
                  if(_resultMask && _resultMask.parent)
                  {
                     _resultMask.parent.removeChild(_resultMask);
                  }
               }
            }
         }
         if(_back.currentFrame == 30)
         {
            StoreSocketOutManager.sendFashionCompose(true,_count);
            model.opState = 2;
         }
         if(_back.currentFrame == _back.totalFrames)
         {
            reset();
         }
      }
      
      private function __resetMovieclipHandler(param1:FashionEvent) : void
      {
         reset();
      }
      
      private function reset() : void
      {
         if(_back)
         {
            _back.removeEventListener("enterFrame",__enterFrameHandler);
            _back.gotoAndStop(1);
            _back["result"].addChild(_cell1);
            _back["result"].addChild(_resultMask);
            _back["grow1"].gotoAndStop(1);
            _back["grow2"].gotoAndStop(1);
            _back["bag1"].addChild(_fashion1);
            _back["bag2"].addChild(_fashion2);
            _back["bag3"].addChild(_fashion3);
            _back["bag4"].addChild(_fashion4);
            _back["grow1"].visible = _back["grow2"].visible = false;
            model.opState = 0;
         }
      }
      
      private function get model() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      private function __onComposeCallback(param1:SLGSocketEvent) : void
      {
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:FashionBagCell = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_ && fashionModel.selectedPanel == "FASHION_COMPOSE_PANEL")
         {
            _loc2_.data = _loc3_;
            updateView();
         }
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:FashionBagCell = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_ && fashionModel.selectedPanel == "FASHION_COMPOSE_PANEL")
         {
            _loc2_.data = null;
            updateView();
         }
      }
      
      private function updateView(param1:Boolean = false) : void
      {
         if(_composeBtn)
         {
            _composeBtn.enable = Boolean(_cell1.data);
         }
         if(_cell1)
         {
            _cell1.countText.setFrame(1);
            _cell1.data = _cell1.data;
         }
         if(_cell1.data == null)
         {
            fashionModel.to_pos = 0;
         }
         updateInputView(param1);
         updateAddView();
      }
      
      private function updateInputView(param1:Boolean = false) : void
      {
         _reduceBtn.enable = false;
         _addBtn.enable = false;
         _minBtn.enable = false;
         _maxBtn.enable = false;
         _composeNumTxt.type = "dynamic";
         if(!_cell1.data)
         {
            _count = 0;
            _composeNumTxt.text = _count + "";
         }
         else if(_cell1.data.templateId == 208021 || _cell1.data.templateId == 208020)
         {
            if(!param1)
            {
               _count = _cell1.data.count;
               _composeNumTxt.text = _count + "";
            }
            _reduceBtn.enable = true;
            _addBtn.enable = true;
            _minBtn.enable = true;
            _maxBtn.enable = true;
            if(_count <= 1)
            {
               _reduceBtn.enable = false;
               _minBtn.enable = false;
            }
            if(_count >= _cell1.data.count)
            {
               _addBtn.enable = false;
               _maxBtn.enable = false;
            }
            _composeNumTxt.type = "input";
         }
         else
         {
            _count = 1;
            _composeNumTxt.text = _count + "";
         }
      }
      
      private function updateAddView() : void
      {
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         _progressBlue.visible = false;
         _progressAddTxt.visible = false;
         if(_colorManager)
         {
            _colorManager.stop();
         }
         if(!_cell1.data)
         {
            return;
         }
         var _loc1_:int = calcGp;
         var _loc3_:FashionInfoMsg = ArmyManager.instance.fashionInfoMsg;
         var _loc5_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc3_.grades + 1,113);
         if(_loc5_)
         {
            _loc6_ = _loc3_.gp + _loc1_;
            _loc4_ = int(_loc5_.Data);
            if(_loc6_ > _loc4_)
            {
               _loc6_ = _loc4_;
            }
            _loc2_ = _loc6_ / _loc4_ * 100;
            _progressAddTxt.text = "+" + _loc1_;
            _progressBlue.visible = true;
            _progressAddTxt.visible = true;
            _colorManager = new MainToolBtnGlowEffect(_progressBlue);
            _colorManager.play1();
         }
         _progressBlue.gotoAndStop(_loc2_);
      }
      
      private function __refreshHandler(param1:NotificationEvent = null) : void
      {
         var _loc2_:FashionBagCell = null;
         var _loc10_:SimpleDictionary = null;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         for each(_loc2_ in _fashionDic)
         {
            _loc2_.data = null;
         }
         if(model.lookDragonTalkerFashion)
         {
            _loc10_ = ArmyManager.instance.dragonFashionList;
         }
         else
         {
            _loc10_ = ArmyManager.instance.fashionList;
         }
         for each(var _loc11_:GoodsInfo in _loc10_)
         {
            _loc2_ = _fashionDic[_loc11_.pos + "_" + thane.id + "_" + _loc11_.bagType];
            if(_loc2_)
            {
               _loc2_.data = _loc11_;
            }
         }
         var _loc3_:FashionInfoMsg = ArmyManager.instance.fashionInfoMsg;
         _levelTxt.text = _loc3_.grades.toString();
         var _loc7_:UpgradeTemplateInfo = TempleteManager.instance.getTemplateByLevelAndType(_loc3_.grades + 1,113);
         if(!_loc7_)
         {
            _progressTxt.text = "max";
            _loc4_ = 100;
         }
         else
         {
            _loc8_ = int(_loc3_.gp);
            _loc6_ = int(_loc7_.Data);
            _progressTxt.text = _loc8_ + "/" + _loc6_;
            _loc4_ = _loc8_ / _loc6_ * 100;
         }
         _progressGreen.gotoAndStop(_loc4_);
         _progressStrip.tipData = _loc3_.grades;
         loop2:
         for each(_loc11_ in _loc10_)
         {
            var _loc17_:int = 0;
            var _loc16_:SimpleDictionary = _composeOldIds;
            do
            {
               for(var _loc9_:String in _loc16_)
               {
               }
               continue loop2;
            }
            while(!(_loc11_.pos == int(_loc9_) && _loc11_.templateId != _composeOldIds[_loc9_]));
            _loc5_ = int(_loc11_.pos);
            _composeOldIds[_loc9_] = _loc11_.templateId;
         }
         if(param1 && _loc5_ != 0)
         {
            _composeResultNew.x = _composeNewPos[_loc5_ - 8];
            _composeResultNew.play();
            addChild(_composeResultNew);
            Helpers.addOneTimeScript(_composeResultNew,_composeResultNew.totalFrames - 1,onFrameEnd);
         }
      }
      
      private function onFrameEnd() : void
      {
         _composeResultNew.stop();
         _composeResultNew.gotoAndStop(1);
         if(_composeResultNew && _composeResultNew.parent)
         {
            _composeResultNew.parent.removeChild(_composeResultNew);
         }
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      private function get calcGp() : int
      {
         var _loc6_:SkillTempInfo = null;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:GoodsInfo = _cell1.data as GoodsInfo;
         if(GoodsCheck.isFashion(_loc4_.templateInfo))
         {
            _loc5_ = 1;
            while(_loc5_ <= 5)
            {
               _loc2_ = int(_loc4_["randomSkill" + _loc5_]);
               _loc6_ = TempleteManager.instance.getSkillTemplateInfoById(_loc2_);
               if(_loc6_)
               {
                  break;
               }
               _loc5_++;
            }
            _loc3_ = 1;
            if(_loc6_)
            {
               _loc3_ = int(_loc6_.Grades);
            }
            _loc3_ = int(_loc3_ > 12 ? 12 : _loc3_);
            _loc3_ = int(_loc3_ <= 0 ? 1 : _loc3_);
            if(_loc4_.templateInfo.SonType == 109)
            {
               _loc7_ = getFashionWingBaseGp();
            }
            else
            {
               _loc7_ = getFashionOtherBaseGp();
            }
            _loc1_ = _loc7_ * Math.pow(2,_loc3_ - 1);
         }
         else
         {
            if(_loc4_.templateId == 208021)
            {
               _loc7_ = getFashionLuckyBaseGp();
            }
            else if(_loc4_.templateId == 208020)
            {
               _loc7_ = getFashionSoulBaseGp();
            }
            _loc1_ = _loc7_ * _count;
         }
         return _loc1_;
      }
      
      private function getFashionLuckyBaseGp() : int
      {
         return int(TempleteManager.instance.getConfigInfoByConfigName("Fashion_Lucky").ConfigValue);
      }
      
      private function getFashionSoulBaseGp() : int
      {
         return int(TempleteManager.instance.getConfigInfoByConfigName("Fashion_Soul").ConfigValue);
      }
      
      private function getFashionWingBaseGp() : int
      {
         return int(TempleteManager.instance.getConfigInfoByConfigName("Fashion_Wing").ConfigValue);
      }
      
      private function getFashionOtherBaseGp() : int
      {
         return int(TempleteManager.instance.getConfigInfoByConfigName("Fashion_Other").ConfigValue);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         if(_isDie)
         {
            return;
         }
         _isDie = true;
         removeEvent();
         fashionModel.opState = 0;
         ObjectUtils.disposeViolentMc(_back);
         _back = null;
         ObjectUtils.disposeObject(_composeBtn);
         _composeBtn = null;
         ObjectUtils.disposeObject(_fashion1);
         _fashion1 = null;
         ObjectUtils.disposeObject(_fashion2);
         _fashion2 = null;
         ObjectUtils.disposeObject(_fashion3);
         _fashion3 = null;
         ObjectUtils.disposeObject(_fashion4);
         _fashion4 = null;
         for(var _loc1_:String in _fashionDic)
         {
            ObjectUtils.disposeObject(_fashionDic[_loc1_]);
            delete _fashionDic[_loc1_];
         }
         if(_itemDic)
         {
            _itemDic.clear();
         }
         ObjectUtils.disposeObject(_progressBg);
         _progressBg = null;
         ObjectUtils.disposeViolentMc(_progressGreen);
         _progressGreen = null;
         ObjectUtils.disposeViolentMc(_progressBlue);
         _progressBlue = null;
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         ObjectUtils.disposeObject(_progressAddTxt);
         _progressAddTxt = null;
         ObjectUtils.disposeObject(_levelBmp);
         _levelBmp = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeViolentMc(_resultMask);
         _resultMask = null;
         ObjectUtils.disposeObject(_progressStrip);
         _progressStrip = null;
         ObjectUtils.disposeViolentMc(_composeResultNew);
         _composeResultNew = null;
         ObjectUtils.disposeObject(_reduceBtn);
         _reduceBtn = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         ObjectUtils.disposeObject(_minBtn);
         _minBtn = null;
         ObjectUtils.disposeObject(_maxBtn);
         _maxBtn = null;
         ObjectUtils.disposeObject(_numBg);
         _numBg = null;
         ObjectUtils.disposeObject(_composeNumTxt);
         _composeNumTxt = null;
         _filter = null;
         _colorManager = null;
         _composeNewPos = null;
         _composeOldIds = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

