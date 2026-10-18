package consortia.view.fb
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.view.fb.item.GuildFBNodeItem;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.GuildFbController;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.guildfb.GuildFBModel;
   import mvc.module.guildfb.GuildFBNode;
   import utils.LogicUtils;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.FlickerHelper;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class GuildFBMainUIView extends Sprite
   {
      
      private var _mainBack:MutipleImage;
      
      private var _allrewardBtn:BaseButton;
      
      private var _topUI:GuildFBTopUIView;
      
      private var _botoomUI:GuildFBBotoomUIView;
      
      private var _normalBtn:BaseButton;
      
      private var _advanceBtn:BaseButton;
      
      private var _bigRightBtn:BaseButton;
      
      private var _bigLeftBtn:BaseButton;
      
      private var _enterShopBtn:BaseButton;
      
      private var _map:ScaleFrameImage;
      
      private var _mapEffect:Bitmap;
      
      private var _botoomTitle:ScaleFrameImage;
      
      private var _nodeList:Vector.<GuildFBNodeItem>;
      
      private var _areaIdx:int = 1;
      
      private const posList:Array = [[[256,238],[239,372],[330,444],[462,405],[517,303],[648,237],[619,371],[682,468],[796,404],[893,341],[908,213],[796,161]],[[355,263],[382,345],[479,364],[564,288],[674,304],[640,405],[731,482],[836,456],[891,371],[863,277],[779,225],[682,175]],[[320,510],[427,491],[491,408],[427,335],[416,252],[510,202],[622,215],[688,292],[784,369],[897,303],[881,189],[798,125]],[[449,220],[339,278],[393,361],[477,426],[578,471],[706,420],[633,318],[577,216],[694,167],[733,277],[790,395],[846,285]],[[442,389],[413,503],[524,529],[655,489],[754,427],[713,324],[570,326],[524,239],[612,167],[710,234],[810,262],[771,156]]];
      
      private const ONE_AREA_NODE_MAX:int = 12;
      
      private const MAX_PAGE:int = 5;
      
      private const MIN_PAGE:int = 1;
      
      public function GuildFBMainUIView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get areaIdx() : int
      {
         return _areaIdx;
      }
      
      public function set areaIdx(param1:int) : void
      {
         var _loc2_:GuildFBNodeItem = null;
         var _loc5_:int = 0;
         _areaIdx = param1;
         _bigLeftBtn.enable = _areaIdx != 1;
         _bigRightBtn.enable = _areaIdx != 5;
         _map.setFrame(_areaIdx);
         _botoomTitle.setFrame(_areaIdx);
         if(_areaIdx == 1)
         {
            _botoomTitle.x = 572;
         }
         else
         {
            _botoomTitle.x = 537;
         }
         var _loc6_:Array = model.getFightNodeListByDiff(_areaIdx,model.currSelectDiff);
         _loc6_.sortOn("nodeID",16);
         var _loc4_:int = int(_loc6_.length);
         _loc5_ = 0;
         while(_loc5_ < 12)
         {
            _loc2_ = _nodeList[_loc5_];
            _loc2_.x = posList[_areaIdx - 1][_loc5_][0];
            _loc2_.y = posList[_areaIdx - 1][_loc5_][1];
            _loc2_.refreshIdx(_areaIdx,_loc5_ + 1);
            if(_loc5_ < _loc4_)
            {
               _loc2_.data = _loc6_[_loc5_];
            }
            else
            {
               _loc2_.data = null;
            }
            _loc5_++;
         }
         var _loc3_:int = int(model.getFightRewards());
         if(_loc3_ >= 1)
         {
            FlickerHelper.setFilcker(_allrewardBtn);
            _allrewardBtn.visible = true;
         }
         else
         {
            _allrewardBtn.visible = false;
            FlickerHelper.clearFilcker(_allrewardBtn);
         }
      }
      
      private function initView() : void
      {
         var _loc1_:GuildFBNodeItem = null;
         var _loc2_:int = 0;
         _mainBack = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.mainBack");
         _allrewardBtn = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.allrewardBtn");
         _topUI = ComponentFactory.Instance.creatCustomObject("ui.guildfb.topUI");
         _botoomUI = ComponentFactory.Instance.creatCustomObject("ui.guildfb.botoomUI");
         _normalBtn = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.normalBtn");
         _advanceBtn = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.advanceBtn");
         _bigRightBtn = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.bigRightBtn");
         _bigLeftBtn = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.bigLeftBtn");
         _enterShopBtn = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.enterShopBtn");
         _map = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.map");
         _botoomTitle = ComponentFactory.Instance.creatComponentByStylename("ui.guildfb.botoomTitle");
         _mapEffect = ComponentFactory.Instance.creatBitmap("asset.guildfb.diffMask");
         addChild(_map);
         addChild(_mapEffect);
         addChild(_mainBack);
         addChild(_allrewardBtn);
         addChild(_topUI);
         addChild(_botoomUI);
         addChild(_normalBtn);
         addChild(_advanceBtn);
         addChild(_bigRightBtn);
         addChild(_enterShopBtn);
         addChild(_bigLeftBtn);
         addChild(_botoomTitle);
         _nodeList = new Vector.<GuildFBNodeItem>();
         _loc2_ = 0;
         while(_loc2_ < 12)
         {
            _loc1_ = new GuildFBNodeItem();
            addChild(_loc1_);
            _nodeList[_loc2_] = _loc1_;
            _loc2_++;
         }
         autoGotoCurrFightNode();
         _topUI.data = model.raceNode;
      }
      
      private function autoGotoCurrFightNode() : void
      {
         var _loc2_:int = 1;
         var _loc1_:GuildFBNode = model.currFightNode;
         if(_loc1_ && _loc1_.currTempInfo != null)
         {
            _loc2_ = int(_loc1_.currTempInfo.AreaId);
            model.currSelectDiff = _loc1_.currTempInfo.Difficulty;
         }
         refreshView(_loc2_);
      }
      
      private function refreshView(param1:int) : void
      {
         areaIdx = param1;
         _normalBtn.visible = model.currSelectDiff == 1;
         _advanceBtn.visible = model.currSelectDiff == 0;
         _mapEffect.visible = _normalBtn.visible;
      }
      
      private function get model() : GuildFBModel
      {
         return FrameControllerManager.instance.guildFbController.model;
      }
      
      private function initEvent() : void
      {
         _normalBtn.addEventListener("click",normalClickHandler);
         _advanceBtn.addEventListener("click",advanceClickHandler);
         _bigRightBtn.addEventListener("click",rightClickHandler);
         _bigLeftBtn.addEventListener("click",leftClickHandler);
         _allrewardBtn.addEventListener("click",allRewardClickHandler);
         _enterShopBtn.addEventListener("click",shopClickHandler);
         MsgMan.addObserver("GuildFBModel.fightNode",this,nodeChangeHandler);
         MsgMan.addObserver("GuildFBModel.raceNode",this,raceChangeHandler);
         MsgMan.addObserver("GuildFBModel.raceReset",this,raceResetHandler);
      }
      
      private function removeEvent() : void
      {
         _normalBtn.removeEventListener("click",normalClickHandler);
         _advanceBtn.removeEventListener("click",advanceClickHandler);
         _bigRightBtn.removeEventListener("click",rightClickHandler);
         _bigLeftBtn.removeEventListener("click",leftClickHandler);
         _enterShopBtn.removeEventListener("click",shopClickHandler);
         _allrewardBtn.removeEventListener("click",allRewardClickHandler);
         MsgMan.removeObserver("GuildFBModel.fightNode",this,nodeChangeHandler);
         MsgMan.removeObserver("GuildFBModel.raceNode",this,raceChangeHandler);
         MsgMan.removeObserver("GuildFBModel.raceReset",this,raceResetHandler);
         FlickerHelper.clearFilcker(_allrewardBtn);
      }
      
      private function allRewardClickHandler(param1:MouseEvent) : void
      {
         control.requestOp(4);
      }
      
      private function get control() : GuildFbController
      {
         return FrameControllerManager.instance.guildFbController;
      }
      
      private function normalClickHandler(param1:MouseEvent) : void
      {
         model.currSelectDiff = 0;
         refreshView(1);
      }
      
      private function advanceClickHandler(param1:MouseEvent) : void
      {
         if(!model.isPassNormal)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("guildfb.advance.tip"));
            return;
         }
         autoGotoCurrFightNode();
      }
      
      private function rightClickHandler(param1:MouseEvent) : void
      {
         areaIdx = areaIdx + 1;
         if(_areaIdx > 5)
         {
            _areaIdx = 5;
         }
      }
      
      private function leftClickHandler(param1:MouseEvent) : void
      {
         areaIdx = areaIdx - 1;
         if(_areaIdx <= 1)
         {
            _areaIdx = 1;
         }
      }
      
      private function shopClickHandler(param1:MouseEvent) : void
      {
         if(playerModel.playerInfo.consortiaID <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.guild_skillPrompt_2"));
            return;
         }
         if(consortiaInfo.shopLevel <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("armyII.viewII.information.GoodsExchangeItem.guild_skillPrompt_3"));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("shop",2,{"type":3});
      }
      
      private function raceChangeHandler(param1:String, param2:Object) : void
      {
         _topUI.data = model.raceNode;
      }
      
      private function nodeChangeHandler(param1:String, param2:Object) : void
      {
         refreshView(_areaIdx);
      }
      
      private function raceResetHandler(param1:String, param2:Object) : void
      {
         refreshView(1);
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function get consortiaInfo() : ConsortiaInfo
      {
         return FrameControllerManager.instance.consortiaController.model.consortiaInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_mainBack);
         _mainBack = null;
         ObjectUtils.disposeObject(_allrewardBtn);
         _allrewardBtn = null;
         ObjectUtils.disposeObject(_topUI);
         _topUI = null;
         ObjectUtils.disposeObject(_botoomUI);
         _botoomUI = null;
         ObjectUtils.disposeObject(_normalBtn);
         _normalBtn = null;
         ObjectUtils.disposeObject(_advanceBtn);
         _advanceBtn = null;
         ObjectUtils.disposeObject(_bigRightBtn);
         _bigRightBtn = null;
         ObjectUtils.disposeObject(_bigLeftBtn);
         _bigLeftBtn = null;
         ObjectUtils.disposeObject(_enterShopBtn);
         _enterShopBtn = null;
         ObjectUtils.disposeObject(_map);
         _map = null;
         ObjectUtils.disposeObject(_mapEffect);
         _mapEffect = null;
         ObjectUtils.disposeObject(_botoomTitle);
         _botoomTitle = null;
         LogicUtils.disposeDisplayCollection(_nodeList);
         _nodeList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

