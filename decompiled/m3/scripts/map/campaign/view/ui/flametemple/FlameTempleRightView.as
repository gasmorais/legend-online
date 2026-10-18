package map.campaign.view.ui.flametemple
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mainBar.StripView;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignSocketOutManager;
   import map.campaign.data.PvpWarFightInfo;
   import map.campaign.data.PvpWarFightModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class FlameTempleRightView extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _teamImg:Image;
      
      private var _scoreImg:Image;
      
      private var _rewardsImg:Image;
      
      private var _teamLogo:ScaleFrameImage;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _rewardItemView1:BaseItemView;
      
      private var _rewardItemView2:BaseItemView;
      
      private var _rankBtn:TextButton;
      
      private var _helpBtn:BaseButton;
      
      private var rewardGoods1:GoodsInfo;
      
      private var rewardGoods2:GoodsInfo;
      
      private var _rewardItemTips1:StripView;
      
      private var _rewardItemTips2:StripView;
      
      private var _model:PvpWarFightModel;
      
      private var _warInfo:PvpWarFightInfo;
      
      private var _rankFrame:FlameTempleScoreRankView;
      
      public function FlameTempleRightView()
      {
         super();
         _model = CampaignManager.instance.pvpWarFightModel;
         _warInfo = _model.pvpWarFightInfo;
         rewardGoods1 = new GoodsInfo();
         rewardGoods2 = new GoodsInfo();
         rewardGoods1.templateId = 208031;
         rewardGoods2.templateId = 208014;
         initView();
         addEvent();
         update();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("flameTempleRightView.bg");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("flameTempleRightView.helpBtn");
         _teamImg = ComponentFactory.Instance.creatComponentByStylename("flameTempleRightView.teamImg");
         _scoreImg = ComponentFactory.Instance.creatComponentByStylename("flameTempleRightView.scoreImg");
         _rewardsImg = ComponentFactory.Instance.creatComponentByStylename("flameTempleRightView.rewardsImg");
         _teamLogo = ComponentFactory.Instance.creatComponentByStylename("flameTempleRightView.teamLogo");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("flameTempleRightView.scoreTxt");
         _rewardItemView1 = ComponentFactory.Instance.creatCustomObject("flameTempleRightView.rewardItemView");
         _rewardItemView2 = ComponentFactory.Instance.creatCustomObject("flameTempleRightView.rewardItemView");
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("flameTempleRightView.rankBtn");
         _rewardItemTips1 = ComponentFactory.Instance.creatCustomObject("flameTempleRightView.rewardItemTips");
         _rewardItemTips2 = ComponentFactory.Instance.creatCustomObject("flameTempleRightView.rewardItemTips2");
         _rewardItemTips1.addChild(_rewardItemView1);
         _rewardItemTips2.addChild(_rewardItemView2);
         _rewardItemView1.mouseEnabled = _rewardItemView1.mouseChildren = false;
         _rewardItemView2.mouseEnabled = _rewardItemView2.mouseChildren = false;
         _rewardItemTips1.tipData = LanguageMgr.GetTranslation("map.campaign.view.ui.flametemple.FlameTempleRightView.RewardItemTips",15,12,10,6);
         _rewardItemTips2.tipData = LanguageMgr.GetTranslation("map.campaign.view.ui.flametemple.FlameTempleRightView.RewardItem2Tips",40,30,20,10);
         addChild(_bg);
         addChild(_helpBtn);
         addChild(_teamImg);
         addChild(_scoreImg);
         addChild(_rewardsImg);
         addChild(_teamLogo);
         addChild(_scoreTxt);
         addChild(_rewardItemTips1);
         addChild(_rewardItemTips2);
         addChild(_rankBtn);
         _rankBtn.text = LanguageMgr.GetTranslation("colosseum.view.HeroRankFrame.rank");
         _rewardItemView1.data = rewardGoods1;
         _rewardItemView2.data = rewardGoods2;
         _teamLogo.setFrame(1);
         _scoreTxt.text = "0";
      }
      
      private function uintView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_teamImg);
         _teamImg = null;
         ObjectUtils.disposeObject(_scoreImg);
         _rewardsImg = null;
         ObjectUtils.disposeObject(_teamLogo);
         _teamLogo = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_rewardItemView1);
         _rewardItemView1 = null;
         ObjectUtils.disposeObject(_rewardItemView2);
         _rewardItemView2 = null;
         ObjectUtils.disposeObject(_rankBtn);
         _rankBtn = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         ObjectUtils.disposeObject(_rewardItemTips1);
         _rewardItemTips1 = null;
         ObjectUtils.disposeObject(_rewardItemTips2);
         _rewardItemTips2 = null;
         if(_rankFrame && !_rankFrame.isDie)
         {
            _rankFrame.dispose();
            _rankFrame = null;
         }
         rewardGoods1 = null;
         rewardGoods2 = null;
         _model = null;
         _warInfo = null;
      }
      
      private function addEvent() : void
      {
         _helpBtn.addEventListener("click",__helpClickHandler);
         _rankBtn.addEventListener("click",__onRankClickHandler);
         _warInfo.addEventListener("PVP_WAR_FIGHT_INFO_CHAGE",__changeHandler);
      }
      
      private function removeEvent() : void
      {
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpClickHandler);
         }
         if(_rankBtn)
         {
            _rankBtn.removeEventListener("click",__onRankClickHandler);
         }
         if(_warInfo)
         {
            _warInfo.removeEventListener("PVP_WAR_FIGHT_INFO_CHAGE",__changeHandler);
         }
      }
      
      private function __helpClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("worldboss.pvpHelperFrame2");
         _loc2_.show();
      }
      
      private function __onRankClickHandler(param1:MouseEvent) : void
      {
         if(_rankFrame && !_rankFrame.isDie)
         {
            _rankFrame.dispose();
            _rankFrame = null;
            return;
         }
         _rankFrame = ComponentFactory.Instance.creatComponentByStylename("flameTemple.scoreRankView");
         _rankFrame.show();
         CampaignSocketOutManager.instance.requestWarFightOrderList();
      }
      
      private function __changeHandler(param1:Event) : void
      {
         update();
      }
      
      public function update() : void
      {
         if(_warInfo.teamId > 0)
         {
            _teamLogo.setFrame(_warInfo.teamId);
         }
         _scoreTxt.text = _warInfo.score.toString();
      }
      
      public function dispose() : void
      {
         removeEvent();
         uintView();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

