package fish
{
   import com.greensock.TimelineLite;
   import com.greensock.TweenMax;
   import com.greensock.core.TweenCore;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.FishEvent;
   import fish.view.FishBagFrame;
   import fish.view.FishHelpView;
   import fish.view.FishSimpleHelpFrame;
   import fish.view.FishSortFrame;
   import fish.view.FishToolItem;
   import fish.view.FishView;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import managers.FishManager;
   import mvc.module.fish.FishForkInfo;
   import mvc.module.fish.FishModel;
   import mvc.module.fish.FishPoolInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.TimeDownView;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.tips.MessageTipManager;
   
   public class FishFrame extends Frame implements IManualSize
   {
      
      private var _back:Scale9CornerImage;
      
      private var _fishBack:Scale9CornerImage;
      
      private var _spliceline:ScaleBitmapImage;
      
      private var _fishFrameBg:Bitmap;
      
      private var _fishCDTxt:Bitmap;
      
      private var _coolCDBtn:BaseButton;
      
      private var _sortLinkTxt:FilterFrameText;
      
      private var _fishExpTxt:FilterFrameText;
      
      private var _scoreBitmap:Bitmap;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _countText:FilterFrameText;
      
      private var _countBg:MutipleImage;
      
      private var _countBitmap:Bitmap;
      
      private var _countBorder:Bitmap;
      
      private var _stripView:StripView;
      
      private var _fishLevelMc:MovieClip;
      
      private var _shareMc:MovieClip;
      
      private var _levelTxtMc:MovieClip;
      
      private var _numBitmapData:BitmapData;
      
      private var _fishCD:TimeDownView;
      
      private var _fishView:FishView;
      
      private var _fishHelpView:FishHelpView;
      
      private var _hBox:HBox;
      
      private var fishToolItem1:FishToolItem;
      
      private var fishToolItem2:FishToolItem;
      
      private var fishToolItem3:FishToolItem;
      
      private var fishToolItem4:FishToolItem;
      
      private var _addBtn1:BaseButton;
      
      private var _addBtn2:BaseButton;
      
      private var _addBtn3:BaseButton;
      
      private var _addBtn4:BaseButton;
      
      private var _corner1:Bitmap;
      
      private var _corner2:Bitmap;
      
      private var _corner3:Bitmap;
      
      private var _corner4:Bitmap;
      
      private var _data:FishPoolInfo;
      
      private var frameIndex:int;
      
      private var _cdTime:Number;
      
      private const totalTime:int = 1800;
      
      private var toolId:int;
      
      private var _backMc:MovieClip;
      
      public var userId:int;
      
      private var _tweenCore:TweenCore;
      
      public function FishFrame()
      {
         super();
         initView();
         addEvent();
         __updateFishPoolHandler(null);
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,940,560);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("fish.FishFrame.titleText");
         _back = ComponentFactory.Instance.creatComponentByStylename("fish.FishFrame.back");
         _fishBack = ComponentFactory.Instance.creatComponentByStylename("fish.FishFrame.fishBack");
         _spliceline = ComponentFactory.Instance.creatComponentByStylename("fish.Spliceline");
         _fishFrameBg = ComponentFactory.Instance.creatBitmap("asset.fish.FishFrame.bg");
         _fishCDTxt = ComponentFactory.Instance.creatBitmap("asset.fish.FishFrame.fishCDTxt");
         _sortLinkTxt = ComponentFactory.Instance.creatComponentByStylename("fish.FishFrame.SortLinkTxt");
         _fishExpTxt = ComponentFactory.Instance.creatComponentByStylename("fish.FishFrame.fishExpTxt");
         _countText = ComponentFactory.Instance.creatComponentByStylename("fish.FishFrame.countText");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("fish.FishFrame.scoreText");
         _scoreBitmap = ComponentFactory.Instance.creatBitmap("asset.FishFrame.score");
         _countBg = ComponentFactory.Instance.creatComponentByStylename("fish.FishFrame.countBg");
         _countBitmap = ComponentFactory.Instance.creatBitmap("asset.fish.FishFrame.count");
         _fishLevelMc = ComponentFactory.Instance.creatCustomObject("fish.FishLevelMc");
         _shareMc = ComponentFactory.Instance.creatCustomObject("fish.FishShareMc");
         _stripView = ComponentFactory.Instance.creatCustomObject("fish.levelView");
         _fishView = ComponentFactory.Instance.creatCustomObject("fish.FishView");
         _fishHelpView = ComponentFactory.Instance.creatCustomObject("fish.FishHelpView");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("fish.FishFrame.hBox");
         _fishCD = ComponentFactory.Instance.creatComponentByStylename("fish.FishFrame.fishCD");
         _levelTxtMc = ComponentFactory.Instance.creatCustomObject("fish.LevelTxtMc");
         _numBitmapData = ComponentFactory.Instance.creatBitmapData("asset.fish.LevelNum").clone();
         _corner1 = ComponentFactory.Instance.creatBitmap("asset.fish.FishViewback1");
         _corner2 = ComponentFactory.Instance.creatBitmap("asset.fish.FishViewback2");
         _corner3 = ComponentFactory.Instance.creatBitmap("asset.fish.FishViewback3");
         _corner4 = ComponentFactory.Instance.creatBitmap("asset.fish.FishViewback4");
         fishToolItem1 = ComponentFactory.Instance.creatCustomObject("view.FishToolItem",[1]);
         fishToolItem1.tipData = LanguageMgr.GetTranslation("fish.FishFrame.toolTip1");
         fishToolItem2 = ComponentFactory.Instance.creatCustomObject("view.FishToolItem",[2]);
         fishToolItem2.tipData = LanguageMgr.GetTranslation("fish.FishFrame.toolTip2");
         fishToolItem3 = ComponentFactory.Instance.creatCustomObject("view.FishToolItem",[3]);
         fishToolItem3.tipData = LanguageMgr.GetTranslation("fish.FishFrame.toolTip3");
         fishToolItem4 = ComponentFactory.Instance.creatCustomObject("view.FishToolItem",[4]);
         fishToolItem4.tipData = LanguageMgr.GetTranslation("fish.FishFrame.toolTip4");
         _addBtn1 = ComponentFactory.Instance.creatComponentByStylename("fish.addBtn");
         _addBtn1.tipData = LanguageMgr.GetTranslation("fish.Frame.toolBuyTips") + LanguageMgr.GetTranslation("fish.FishFrame.toolName1");
         _addBtn1.x = 551;
         _addBtn2 = ComponentFactory.Instance.creatComponentByStylename("fish.addBtn");
         _addBtn2.tipData = LanguageMgr.GetTranslation("fish.Frame.toolBuyTips") + LanguageMgr.GetTranslation("fish.FishFrame.toolName4");
         _addBtn2.x = 626;
         _addBtn3 = ComponentFactory.Instance.creatComponentByStylename("fish.addBtn");
         _addBtn3.tipData = LanguageMgr.GetTranslation("fish.Frame.toolBuyTips") + LanguageMgr.GetTranslation("fish.FishFrame.toolName2");
         _addBtn3.x = 701;
         _addBtn4 = ComponentFactory.Instance.creatComponentByStylename("fish.addBtn");
         _addBtn4.tipData = LanguageMgr.GetTranslation("fish.Frame.toolBuyTips") + LanguageMgr.GetTranslation("fish.FishFrame.toolName3");
         _addBtn4.x = 776;
         _hBox.addChild(fishToolItem1);
         _hBox.addChild(fishToolItem4);
         _hBox.addChild(fishToolItem2);
         _hBox.addChild(fishToolItem3);
         _backMc = ComponentFactory.Instance.creatCustomObject("fish.FishBackMc");
         _stripView.addChild(_fishLevelMc);
         _stripView.setHitArea(10,0,150,25);
         _stripView.tipData = LanguageMgr.GetTranslation("fish.FishFrame.level");
         _fishLevelMc["halo"].visible = false;
         _fishLevelMc.gotoAndStop(1);
         _shareMc.gotoAndStop(1);
         _shareMc.visible = false;
         _levelTxtMc.gotoAndStop(1);
         _sortLinkTxt.htmlText = "<a href =\'event: \'><u>" + LanguageMgr.GetTranslation("fish.Frame.sortBtn") + "</u></a>";
         _sortLinkTxt.mouseEnabled = true;
         addToContent(_fishBack);
         addToContent(_fishFrameBg);
         addToContent(_spliceline);
         addToContent(_countBitmap);
         addToContent(_countText);
         addToContent(_fishCD);
         addToContent(_shareMc);
         addToContent(_fishView);
         _fishView.buttonMode = true;
         addToContent(_corner1);
         addToContent(_corner2);
         addToContent(_corner3);
         addToContent(_corner4);
         addToContent(_fishHelpView);
         _fishHelpView.visible = false;
         addToContent(_hBox);
         addToContent(_addBtn1);
         addToContent(_addBtn2);
         addToContent(_addBtn3);
         addToContent(_addBtn4);
         addToContent(_backMc);
         _backMc.play();
         setVisible(false);
      }
      
      private function setVisible(param1:Boolean) : void
      {
         _stripView.visible = param1;
         _sortLinkTxt.visible = param1;
         _levelTxtMc.visible = param1;
         _scoreTxt.visible = param1;
         _scoreBitmap.visible = param1;
         _countBg.visible = param1;
         _countBitmap.visible = param1;
         _fishLevelMc.visible = param1;
         _fishCDTxt.visible = param1;
         _hBox.visible = param1;
         _addBtn1.visible = param1;
         _addBtn2.visible = param1;
         _addBtn3.visible = param1;
         _addBtn4.visible = param1;
         if(!model.isSelf)
         {
            _fishHelpView.visible = !param1;
            _fishHelpView.setVisible(param1);
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _sortLinkTxt.addEventListener("click",__fishSortHandler);
         model.addEventListener("UPDATE_FISH_POOL",__updateFishPoolHandler);
         model.addEventListener("ORDERDATA_LOAD_COMPLETE",__orderDataLoadCompleteHandler);
         _fishView.addEventListener("click",__clickHandler);
         _fishView.addEventListener("FISH_RAGE",__fishRageHandler);
         model.addEventListener("TIME_OVER",__timeOverHandler);
         model.addEventListener("HELP_OVER",__helpOverHandler);
         _addBtn1.addEventListener("click",__onAddHandler);
         _addBtn2.addEventListener("click",__onAddHandler);
         _addBtn3.addEventListener("click",__onAddHandler);
         _addBtn4.addEventListener("click",__onAddHandler);
      }
      
      private function __onAddHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         toolId = 0;
         if(param1.currentTarget == _addBtn1)
         {
            toolId = 1;
         }
         else if(param1.currentTarget == _addBtn2)
         {
            toolId = 4;
         }
         else if(param1.currentTarget == _addBtn3)
         {
            toolId = 2;
         }
         else
         {
            if(param1.currentTarget != _addBtn4)
            {
               return;
            }
            toolId = 3;
         }
         var _loc2_:int = 10;
         try
         {
            _loc2_ = parseInt(TempleteManager.instance.getConfigInfoByConfigName("FishTool_Point").ConfigValue);
         }
         catch(e:Error)
         {
         }
         finally
         {
            _loc2_ = 10;
         }
         var _loc3_:String = LanguageMgr.GetTranslation("fish.FishFrame.confirmBuy",_loc2_,LanguageMgr.GetTranslation("fish.FishFrame.toolName" + toolId));
         if(SharedManagerHelper.ins.isNeedAlert("fishToolItem_onAddHandler"))
         {
            SharedManagerHelper.ins.needAlert("fishToolItem_onAddHandler",buyGoodsHandlerBack,LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt"),_loc3_);
         }
         else
         {
            buyGoodsHandlerBack();
         }
      }
      
      private function buyGoodsHandlerBack(param1:Boolean = false) : void
      {
         SoundManager.instance.play("022");
         FishManager.instance.fishAction(13,[toolId]);
      }
      
      protected function __timeOverHandler(param1:Event) : void
      {
         _fishHelpView.rageOver();
      }
      
      protected function __helpOverHandler(param1:FishEvent) : void
      {
         if(model.helpSuccess)
         {
            _fishView.helpOver();
         }
         else
         {
            dispose();
         }
      }
      
      protected function __fishRageHandler(param1:FishEvent) : void
      {
         _fishHelpView.visible = true;
         _fishHelpView.setVisible(true);
         _fishHelpView.helpTime.timeCount = 120;
      }
      
      protected function __clickHandler(param1:MouseEvent) : void
      {
         if(!model.isSelf)
         {
            return;
         }
         if(param1.target == _fishView.fishBagBtn)
         {
            return;
         }
         _shareMc.visible = false;
         if(model.fishPoolInfo.count > 0 && model.fishPoolInfo.count >= model.fishPoolInfo.maxCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("fish.FishFrame.NotCount"));
            return;
         }
         if(GoodsManager.instance.getFishBagList().getList().length >= 21)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("fish.FishFrame.FishBagFull"));
            return;
         }
         _fishView.clickView();
      }
      
      private function openKingCall() : void
      {
         CheckUIModuleUtil.instance.tryCall("quickbuy",showBuyFrameCall);
      }
      
      private function showBuyFrameCall() : void
      {
         var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
         var _loc2_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(2031701);
         _loc1_.data(_loc2_);
         _loc1_.show();
      }
      
      private function allCoolBack(param1:Boolean, param2:Boolean, param3:int) : void
      {
         if(param1)
         {
            if(param2)
            {
               FishManager.instance.fishAction(3,[1]);
            }
            else
            {
               FishManager.instance.fishAction(3,[0]);
            }
         }
      }
      
      private function __fishBagHandler(param1:MouseEvent) : void
      {
         var _loc2_:FishBagFrame = ComponentFactory.Instance.creatComponentByStylename("fish.FishBagFrame");
         _loc2_.show();
      }
      
      private function __fishSortHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.fishControler.loadFishOrderData();
      }
      
      private function __orderDataLoadCompleteHandler(param1:FishEvent) : void
      {
         var _loc2_:FishSortFrame = ComponentFactory.Instance.creatComponentByStylename("fish.FishSortFrame");
         _loc2_.show();
      }
      
      private function __fishHelpHandler(param1:MouseEvent) : void
      {
         var _loc2_:FishSimpleHelpFrame = null;
         _loc2_ = ComponentFactory.Instance.creatComponentByStylename("fish.fishSimpleHelpFrame");
         _loc2_.show();
      }
      
      private function __updateFishPoolHandler(param1:FishEvent) : void
      {
         if(model.isSelf)
         {
            data = model.fishPoolInfo;
         }
      }
      
      public function set data(param1:FishPoolInfo) : void
      {
         setVisible(true);
         NumberViewUtils.refreshValue(param1.level,_levelTxtMc["content"],_numBitmapData,19,25,15,19,"0123456789");
         if(param1.isLimit)
         {
            _fishExpTxt.text = LanguageMgr.GetTranslation("fish.FishFrame.maxExp");
         }
         else
         {
            _fishExpTxt.text = param1.currentGp + "/" + param1.currentMaxGp;
         }
         _countText.text = LanguageMgr.GetTranslation("fish.FishFrame.countText",param1.count,param1.maxCount);
         _scoreTxt.text = param1.score + "";
         _cdTime = param1.cdTime;
         fishToolItem1.count = param1.tool1;
         fishToolItem2.count = param1.tool2;
         fishToolItem3.count = param1.tool3;
         fishToolItem4.count = param1.tool4;
         frameIndex = Math.max(1,Math.min(100,int(param1.currentGp * 100 / param1.currentMaxGp)));
         if(!_data)
         {
            if(param1.isLimit)
            {
               _fishLevelMc.gotoAndStop(_fishLevelMc.totalFrames);
            }
            else
            {
               _fishLevelMc.gotoAndStop(frameIndex);
            }
         }
         else if(!param1.isLimit)
         {
            updateLevelMc(param1);
         }
         _data = param1;
      }
      
      private function updateCD() : void
      {
         if(_cdTime <= 0)
         {
            _fishCD.timeCount = 0;
         }
         else
         {
            _fishCD.timeCount = _cdTime;
         }
      }
      
      private function updateLevelMc(param1:FishPoolInfo) : void
      {
         var _loc3_:TimelineLite = null;
         disposeTween();
         frameIndex = Math.max(1,Math.min(100,int(param1.currentGp * 100 / param1.currentMaxGp)));
         var _loc2_:Number = 0.3;
         if(param1.level == _data.level || Boolean(param1.isLimit))
         {
            if(frameIndex != _fishLevelMc.currentFrame)
            {
               _fishLevelMc["halo"].visible = true;
               _tweenCore = TweenMax.to(_fishLevelMc,_loc2_,{
                  "frame":frameIndex,
                  "onComplete":__onFinishTween
               });
            }
            else if(_data.currentGp != param1.currentGp)
            {
               _fishLevelMc["halo"].visible = true;
               _tweenCore = TweenMax.to(_fishLevelMc,_loc2_,{
                  "frame":frameIndex,
                  "onComplete":__onFinishTween
               });
            }
         }
         else if(param1.level != _data.level)
         {
            _fishLevelMc["halo"].visible = true;
            _loc3_ = new TimelineLite({"onComplete":__onFinishTween});
            _loc3_.append(TweenMax.to(_fishLevelMc,_loc2_,{"frame":100}));
            _loc3_.append(TweenMax.fromTo(_fishLevelMc,_loc2_,{"frame":1},{"frame":frameIndex}));
            _loc3_.play();
            _tweenCore = _loc3_;
            _loc3_ = null;
         }
      }
      
      private function __onFinishTween() : void
      {
         disposeTween();
      }
      
      private function disposeTween() : void
      {
         if(_tweenCore)
         {
            _tweenCore.kill();
            _tweenCore = null;
         }
         if(_fishLevelMc)
         {
            _fishLevelMc["halo"].visible = false;
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               closeClick();
         }
      }
      
      private function closeClick() : void
      {
         var _loc1_:String = null;
         var _loc5_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         for each(var _loc4_:FishForkInfo in model.fishForkList)
         {
            if(_loc4_.state != 0)
            {
               if(_loc4_.state != 3)
               {
                  MessageTipManager.instance().show(LanguageMgr.GetTranslation("fish.FishFrame.noClose"));
                  return;
               }
            }
         }
         if(!model.isSelf)
         {
            _loc1_ = LanguageMgr.GetTranslation("fish.FishFrame.helperClose");
         }
         else if(model.rage)
         {
            _loc1_ = LanguageMgr.GetTranslation("fish.FishFrame.selfClose");
         }
         if(_loc1_)
         {
            SimpleAlertHelper.instance.data = [exit];
            _loc5_ = LanguageMgr.GetTranslation("public.prompt");
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            SimpleAlertHelper.instance.popAlerFrame(_loc5_,_loc1_,_loc2_,_loc3_,true);
         }
         else
         {
            exit(true,true);
         }
      }
      
      private function exit(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            model.rage = false;
            FishManager.instance.fishAction(8);
            dispose();
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _sortLinkTxt.removeEventListener("click",__fishSortHandler);
         model.removeEventListener("UPDATE_FISH_POOL",__updateFishPoolHandler);
         model.removeEventListener("ORDERDATA_LOAD_COMPLETE",__orderDataLoadCompleteHandler);
         _fishView.removeEventListener("click",__clickHandler);
         _fishView.removeEventListener("FISH_RAGE",__fishRageHandler);
         model.removeEventListener("TIME_OVER",__timeOverHandler);
         model.removeEventListener("HELP_OVER",__helpOverHandler);
         _addBtn1.removeEventListener("click",__onAddHandler);
         _addBtn2.removeEventListener("click",__onAddHandler);
         _addBtn3.removeEventListener("click",__onAddHandler);
         _addBtn4.removeEventListener("click",__onAddHandler);
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1,0,true);
      }
      
      private function get model() : FishModel
      {
         return FishManager.instance.model;
      }
      
      private function get playermodel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function setRefuse() : void
      {
         if(!model.fishRefuseInvite)
         {
            SocketSendManager.instance.sendRefuseInvite();
         }
         if(!model.fishRefuseInvitation)
         {
            SharedManager.instance.refuseInvitation = model.fishRefuseInvitation;
            SharedManager.instance.save();
         }
         if(!model.fishRefuseTeamInvite)
         {
            SocketSendManager.instance.sendRefuseTeamInvite();
         }
      }
      
      override public function dispose() : void
      {
         _data = null;
         disposeTween();
         removeEvent();
         if(_fishLevelMc)
         {
            _fishLevelMc.stop();
         }
         if(_backMc)
         {
            _backMc.stop();
         }
         if(_shareMc)
         {
            _shareMc.stop();
         }
         if(_levelTxtMc)
         {
            _levelTxtMc.stop();
         }
         ObjectUtils.disposeObject(_fishLevelMc);
         _fishLevelMc = null;
         ObjectUtils.disposeObject(_backMc);
         _backMc = null;
         ObjectUtils.disposeObject(_shareMc);
         _shareMc = null;
         ObjectUtils.disposeObject(_levelTxtMc);
         _levelTxtMc = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_fishBack);
         _fishBack = null;
         ObjectUtils.disposeObject(_fishFrameBg);
         _fishFrameBg = null;
         ObjectUtils.disposeObject(_fishCDTxt);
         _fishCDTxt = null;
         ObjectUtils.disposeObject(_sortLinkTxt);
         _sortLinkTxt = null;
         ObjectUtils.disposeObject(_fishExpTxt);
         _fishExpTxt = null;
         ObjectUtils.disposeObject(_scoreBitmap);
         _scoreBitmap = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_countText);
         _countText = null;
         ObjectUtils.disposeObject(_countBg);
         _countBg = null;
         ObjectUtils.disposeObject(_countBitmap);
         _countBitmap = null;
         ObjectUtils.disposeObject(_countBorder);
         _countBorder = null;
         ObjectUtils.disposeObject(_stripView);
         _stripView = null;
         ObjectUtils.disposeObject(_numBitmapData);
         _numBitmapData = null;
         ObjectUtils.disposeObject(_fishCD);
         _fishCD = null;
         ObjectUtils.disposeObject(_fishView);
         _fishView = null;
         ObjectUtils.disposeObject(_fishHelpView);
         _fishHelpView = null;
         ObjectUtils.disposeObject(fishToolItem1);
         fishToolItem1 = null;
         ObjectUtils.disposeObject(fishToolItem2);
         fishToolItem2 = null;
         ObjectUtils.disposeObject(fishToolItem3);
         fishToolItem3 = null;
         ObjectUtils.disposeObject(fishToolItem4);
         fishToolItem4 = null;
         ObjectUtils.disposeObject(_corner1);
         _corner1 = null;
         ObjectUtils.disposeObject(_corner2);
         _corner2 = null;
         ObjectUtils.disposeObject(_corner3);
         _corner3 = null;
         ObjectUtils.disposeObject(_corner4);
         _corner4 = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeAllChildren(this);
         model.clean();
         setRefuse();
         super.dispose();
         KeyBoardRegister.instance.keyEnable = true;
      }
   }
}

