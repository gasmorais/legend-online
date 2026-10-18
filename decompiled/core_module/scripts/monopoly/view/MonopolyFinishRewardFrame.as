package monopoly.view
{
   import bag.helper.BagHelper;
   import chat.datas.ChatData;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectPool;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.campaign.CampaignNodeInfoMsg;
   import com.road.yishi.proto.campaign.TempMsg;
   import events.MonopolyEvent;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.MonopolyManager;
   import managers.MonopolySocketOutManager;
   import mvc.module.monopoly.MonopolyItemInfo;
   import mvc.module.monopoly.MonopolyModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tools.QuickenMovieClip;
   
   public class MonopolyFinishRewardFrame extends Frame
   {
      
      private var _titleImg:Image;
      
      private var _diceIcon:Image;
      
      private var _diceCountTxt:FilterFrameText;
      
      private var _freeCountTxt:FilterFrameText;
      
      private var _startBtn:IconButton;
      
      private var _handleMC:MovieClip;
      
      private var _handleQuickMC:QuickenMovieClip;
      
      private var _contentView:Sprite;
      
      private var _mask:Shape;
      
      private var _rewardView1:MonopolyFinishRewardView;
      
      private var _rewardView2:MonopolyFinishRewardView;
      
      private var _rewardView3:MonopolyFinishRewardView;
      
      private var _hitArea:Sprite;
      
      private var _hitBitmapData:BitmapData;
      
      private var _hitRect:Rectangle;
      
      private var _hitMatrix:Matrix;
      
      private var _itemInfos:Array;
      
      private var _model:MonopolyModel;
      
      private var _data:CampaignNodeInfoMsg;
      
      private var _rewardIndex1:int = -1;
      
      private var _rewardIndex2:int = -1;
      
      private var _rewardIndex3:int = -1;
      
      private var _playMax:int;
      
      private var _playCount:int;
      
      public function MonopolyFinishRewardFrame()
      {
         super();
         _model = MonopolyManager.instance.model;
         _itemInfos = [];
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MONOPOLY_ALERT"];
      }
      
      private function initView() : void
      {
         _titleImg = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFinishRewardFrame.TitleImg");
         _diceIcon = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFinishRewardFrame.DiceIcon");
         _diceCountTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFinishRewardFrame.DiceCountTxt");
         _freeCountTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFinishRewardFrame.FreeCountTxt");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFinishRewardFrame.StartBtn");
         _handleMC = ComponentFactory.Instance.creatCustomObject("monopoly.Handle");
         _handleQuickMC = new QuickenMovieClip(_handleMC);
         addToContent(_titleImg);
         addToContent(_diceIcon);
         addToContent(_diceCountTxt);
         addToContent(_freeCountTxt);
         addToContent(_startBtn);
         addToContent(_handleQuickMC);
         _hitRect = _handleMC.getBounds(_handleMC);
         _hitBitmapData = new BitmapData(_hitRect.width + 10,_hitRect.height,true,0);
         _hitMatrix = new Matrix();
         _hitMatrix.translate(-_hitRect.x,-_hitRect.y);
         _hitBitmapData.draw(_handleMC,_hitMatrix);
         _hitArea = DisplayUtils.getHitArea(_hitBitmapData,5);
         _hitArea.x = _hitRect.x;
         _hitArea.y = _hitRect.y;
         _handleMC.addChild(_hitArea);
         _handleMC.hitArea = _hitArea;
         _handleQuickMC.gotoAndStop(0);
         _handleQuickMC.addFrameScript(_handleQuickMC.totalFrames - 1,handleQuickCallBack);
         _startBtn.enable = true;
         _handleMC.buttonMode = true;
         _contentView = new Sprite();
         _rewardView1 = new MonopolyFinishRewardView();
         _rewardView2 = new MonopolyFinishRewardView();
         _rewardView3 = new MonopolyFinishRewardView();
         _contentView.y = -10;
         _rewardView1.x = 40;
         _rewardView2.x = 150;
         _rewardView3.x = 260;
         _rewardView1.y = _rewardView2.y = _rewardView3.y = -20;
         _contentView.addChild(_rewardView1);
         _contentView.addChild(_rewardView2);
         _contentView.addChild(_rewardView3);
         creatMask();
         _contentView.mask = _mask;
         addToContent(_contentView);
      }
      
      private function creatMask() : void
      {
         _mask = new Shape();
         _mask.graphics.clear();
         _mask.graphics.beginFill(0,0);
         _mask.graphics.drawRect(40,35,300,132);
         _mask.x = _contentView.x;
         _mask.y = _contentView.y;
         addToContent(_mask);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_titleImg);
         _titleImg = null;
         ObjectUtils.disposeObject(_diceIcon);
         _diceIcon = null;
         ObjectUtils.disposeObject(_diceCountTxt);
         _diceCountTxt = null;
         ObjectUtils.disposeObject(_freeCountTxt);
         _freeCountTxt = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_handleMC);
         _handleMC = null;
         ObjectUtils.disposeObject(_handleQuickMC);
         _handleQuickMC = null;
         ObjectUtils.disposeObject(_contentView);
         _contentView = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         ObjectUtils.disposeObject(_rewardView1);
         _rewardView1 = null;
         ObjectUtils.disposeObject(_rewardView2);
         _rewardView2 = null;
         ObjectUtils.disposeObject(_rewardView3);
         _rewardView3 = null;
         ObjectUtils.disposeObject(_hitArea);
         _hitArea = null;
         ObjectUtils.disposeObject(_hitBitmapData);
         _hitBitmapData = null;
         ObjectUtils.disposeAllChildren(this);
         _hitRect = null;
         _hitMatrix = null;
      }
      
      private function addEvent() : void
      {
         _handleMC.addEventListener("click",__handleMCClickHandler);
         _startBtn.addEventListener("click",__startBtnClickHandler);
         _model.addEventListener("MONOPOLY_INFO_CHANGE",__infoChangeHandler);
      }
      
      private function removeEvent() : void
      {
         _handleMC.removeEventListener("click",__handleMCClickHandler);
         _startBtn.removeEventListener("click",__startBtnClickHandler);
         _model.removeEventListener("MONOPOLY_INFO_CHANGE",__infoChangeHandler);
      }
      
      private function __infoChangeHandler(param1:MonopolyEvent) : void
      {
         var _loc6_:TempMsg = null;
         var _loc5_:int = 0;
         var _loc4_:MonopolyItemInfo = _model.itemInfos[0] as MonopolyItemInfo;
         var _loc3_:MonopolyItemInfo = _model.itemInfos[1] as MonopolyItemInfo;
         var _loc2_:MonopolyItemInfo = _model.itemInfos[2] as MonopolyItemInfo;
         _loc5_ = 0;
         while(_loc5_ < _itemInfos.length)
         {
            _loc6_ = _itemInfos[_loc5_] as TempMsg;
            if(_rewardIndex1 == -1 && _loc4_ && _loc6_.templateId == _loc4_.templateId && _loc6_.count == _loc4_.count)
            {
               _rewardIndex1 = _loc5_;
            }
            if(_rewardIndex2 == -1 && _loc3_ && _loc6_.templateId == _loc3_.templateId && _loc6_.count == _loc3_.count)
            {
               _rewardIndex2 = _loc5_;
            }
            if(_rewardIndex3 == -1 && _loc2_ && _loc6_.templateId == _loc2_.templateId && _loc6_.count == _loc2_.count)
            {
               _rewardIndex3 = _loc5_;
            }
            _loc5_++;
         }
         refreshDiceTimes();
         _handleQuickMC.gotoAndPlay(0);
      }
      
      private function __handleMCClickHandler(param1:MouseEvent) : void
      {
         if(_handleMC.buttonMode)
         {
            sendSlotMachine();
         }
      }
      
      private function __startBtnClickHandler(param1:MouseEvent) : void
      {
         if(_startBtn.enable)
         {
            sendSlotMachine();
         }
      }
      
      private function sendSlotMachine() : void
      {
         _startBtn.enable = false;
         _handleMC.buttonMode = false;
         MonopolySocketOutManager.sendSlotMachine();
      }
      
      private function handleQuickCallBack() : void
      {
         _handleQuickMC.gotoAndStop(0);
         _playMax = 0;
         if(_rewardIndex1 != -1)
         {
            _playMax = _playMax + 1;
            _rewardView1.start(rewardPlayCallBack,_rewardIndex1,10);
            _rewardIndex1 = -1;
         }
         if(_rewardIndex2 != -1)
         {
            _playMax = _playMax + 1;
            _rewardView2.start(rewardPlayCallBack,_rewardIndex2,20);
            _rewardIndex2 = -1;
         }
         if(_rewardIndex3 != -1)
         {
            _playMax = _playMax + 1;
            _rewardView3.start(rewardPlayCallBack,_rewardIndex3,30);
            _rewardIndex3 = -1;
         }
      }
      
      private function rewardPlayCallBack() : void
      {
         _playCount = _playCount + 1;
         if(_playCount >= _playMax)
         {
            _playCount = 0;
            showSlotRewardMsg();
            if(_model.normalTimes + _model.magicTimes + _model.slotMachineTimes > 0)
            {
               _startBtn.enable = true;
               _handleMC.buttonMode = true;
            }
            else
            {
               setTimeout(leaveCampaign,1000);
            }
         }
      }
      
      private function showSlotRewardMsg() : void
      {
         var _loc3_:ChatData = null;
         var _loc2_:GoodsTemplateInfo = null;
         var _loc6_:GoodsInfo = null;
         var _loc5_:String = "";
         var _loc1_:String = "";
         for each(var _loc4_:MonopolyItemInfo in _model.itemInfos)
         {
            _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_.templateId);
            if(_loc2_)
            {
               _loc6_ = new GoodsInfo();
               _loc6_.templateId = _loc4_.templateId;
               _loc6_.count = _loc4_.count;
               _loc5_ += LanguageMgr.GetTranslation("MonopolyManager.BattleGetTip02",_loc2_.TemplateName,_loc4_.count);
            }
         }
         if(_loc5_ != "")
         {
            _loc5_ = _loc5_.substring(0,_loc5_.length - 1);
         }
         _loc1_ = LanguageMgr.GetTranslation("MonopolyManager.BattleGetTip01",_loc5_);
         _loc3_ = ObjectPool.getObject(ChatData) as ChatData;
         if(_loc3_)
         {
            _loc3_.channel = 3;
            _loc3_.msg = _loc1_;
            _loc3_.commit();
            NotificationManager.instance.sendNotification("ADD_CHAT",_loc3_);
            MessageTipManager.instance().show(_loc1_);
         }
         if(!_model.isMail)
         {
            BagHelper.instance.playNewGoodsEffect(_loc6_);
         }
         if(_model.isMail)
         {
            _loc1_ = LanguageMgr.GetTranslation("vip.view.VipBoxFrame.command03");
            MessageTipManager.instance().show(_loc1_);
         }
      }
      
      private function leaveCampaign() : void
      {
         MonopolySocketOutManager.sendLeaveCampaign();
         dispose();
      }
      
      private function initItemInfos() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_data)
         {
            _itemInfos = [];
            for each(var _loc3_:TempMsg in _data.nodeInfo)
            {
               _itemInfos.push(_loc3_);
            }
            _rewardView1.initInfos(_itemInfos);
            _rewardView2.initInfos(_itemInfos);
            _rewardView3.initInfos(_itemInfos);
         }
      }
      
      public function refreshDiceTimes() : void
      {
         var _loc1_:int = 0;
         if(_data)
         {
            _loc1_ = _model.normalTimes + _model.magicTimes;
            _diceCountTxt.text = LanguageMgr.GetTranslation("monopoly.view.MonopolyFinishRewardFrame.diceCountTxt",_loc1_);
            _freeCountTxt.text = LanguageMgr.GetTranslation("monopoly.view.MonopolyFinishRewardFrame.freeCountTxt",_model.slotMachineTimes);
            if(_model.slotMachineTimes > 0)
            {
               _diceIcon.x = 105;
               _diceCountTxt.x = 142;
               _freeCountTxt.visible = true;
            }
            else
            {
               _diceIcon.x = 155;
               _diceCountTxt.x = 192;
               _freeCountTxt.visible = false;
            }
         }
      }
      
      public function set data(param1:CampaignNodeInfoMsg) : void
      {
         _data = param1;
         refreshDiceTimes();
         initItemInfos();
      }
      
      public function show() : void
      {
         KeyBoardRegister.instance.keyEnable = false;
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

