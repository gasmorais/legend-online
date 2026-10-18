package map.campaign.view.ui.unrealshooting
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import map.campaign.data.UnrealShootingUserInfo;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class UnrealShootingGameOverFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _sortBg:Image;
      
      private var _rewardBg:Image;
      
      private var _sort:FilterFrameText;
      
      private var _nickName:FilterFrameText;
      
      private var _server:FilterFrameText;
      
      private var _score:FilterFrameText;
      
      private var _fightPower:FilterFrameText;
      
      private var _killNum:FilterFrameText;
      
      private var _selfBg:MutipleImage;
      
      private var _selfItem:UnrealShootingGameOverItem;
      
      private var _vBox:VBox;
      
      private var _rewardGetImg:Image;
      
      private var _hBox:HBox;
      
      private var _rankItemArr:Array;
      
      private var _rewardItemArr:Array;
      
      private var _rankArr:Array;
      
      private var _rewardArr:Array;
      
      private var _myRankIfo:UnrealShootingUserInfo;
      
      private const PAGE_NUM:int = 8;
      
      public function UnrealShootingGameOverFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc1_:UnrealShootingGameOverItem = null;
         var _loc2_:int = 0;
         _bg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingGameOverFrame.bg");
         _sortBg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingGameOverFrame.sortBg");
         _rewardBg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingGameOverFrame.rewardBg");
         _sort = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingGameOverFrame.sort");
         _nickName = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingGameOverFrame.nickName");
         _server = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingGameOverFrame.server");
         _score = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingGameOverFrame.score");
         _fightPower = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingGameOverFrame.fightPower");
         _killNum = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingGameOverFrame.killNum");
         _selfBg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingGameOverFrame.selfBg");
         _vBox = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingGameOverFrame.vbox");
         _selfItem = new UnrealShootingGameOverItem(true);
         _selfItem.y = 45;
         _rewardGetImg = ComponentFactory.Instance.creatComponentByStylename("unrealshooting.UnrealShootingGameOverFrame.rewardGetImg");
         _hBox = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingGameOverFrame.hbox");
         addToContent(_bg);
         addToContent(_sortBg);
         addToContent(_rewardBg);
         addToContent(_sort);
         addToContent(_nickName);
         addToContent(_server);
         addToContent(_score);
         addToContent(_fightPower);
         addToContent(_killNum);
         addToContent(_selfBg);
         addToContent(_selfItem);
         addToContent(_vBox);
         addToContent(_rewardGetImg);
         addToContent(_hBox);
         _rankItemArr = [];
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new UnrealShootingGameOverItem();
            _vBox.addChild(_loc1_);
            _rankItemArr.push(_loc1_);
            _loc2_++;
         }
         _sort.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingGameOverFrame.sort");
         _nickName.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingGameOverFrame.nickName");
         _server.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingGameOverFrame.server");
         _score.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingGameOverFrame.score");
         _fightPower.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingGameOverFrame.fightPower");
         _killNum.text = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingGameOverFrame.killNum");
         titleText = LanguageMgr.GetTranslation("unrealshooting.UnrealShootingGameOverFrame.title");
      }
      
      private function unInitView() : void
      {
         LogicUtils.disposeDisplayCollection(_rankItemArr);
         _rankItemArr = null;
         LogicUtils.disposeDisplayCollection(_rewardItemArr);
         _rewardItemArr = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_sortBg);
         _sortBg = null;
         ObjectUtils.disposeObject(_rewardBg);
         _rewardBg = null;
         ObjectUtils.disposeObject(_sort);
         _sort = null;
         ObjectUtils.disposeObject(_nickName);
         _nickName = null;
         ObjectUtils.disposeObject(_server);
         _server = null;
         ObjectUtils.disposeObject(_score);
         _score = null;
         ObjectUtils.disposeObject(_fightPower);
         _fightPower = null;
         ObjectUtils.disposeObject(_killNum);
         _killNum = null;
         ObjectUtils.disposeObject(_selfBg);
         _selfBg = null;
         ObjectUtils.disposeObject(_selfItem);
         _selfItem = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_rewardGetImg);
         _rewardGetImg = null;
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeSelf(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
      }
      
      public function show(param1:Object) : void
      {
         _rankArr = param1.list;
         _rewardArr = param1.reward;
         _myRankIfo = param1.myRankInfo;
         refreshView();
         LayerManager.Instance.addToLayer(this,3,true,true);
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
      
      private function refreshView() : void
      {
         var _loc3_:UnrealShootingUserInfo = null;
         var _loc1_:String = null;
         var _loc2_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         _selfItem.data = _myRankIfo;
         _hBox.removeAllChild();
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            _loc3_ = _rankArr[_loc4_];
            (_rankItemArr[_loc4_] as UnrealShootingGameOverItem).data = _loc3_;
            _loc4_++;
         }
         _rewardItemArr = [];
         _loc5_ = 0;
         while(_loc5_ < _rewardArr.length)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("unrealshooting.UnrealShootingGameOverFrame.rewardItem");
            _loc6_ = new GoodsInfo();
            _loc1_ = _rewardArr[_loc5_];
            _loc6_.templateId = _loc1_.split(",")[0];
            _loc6_.count = _loc1_.split(",")[1];
            _loc2_.data = _loc6_;
            _hBox.addChild(_loc2_);
            _rewardItemArr.push(_loc2_);
            _loc5_++;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}

