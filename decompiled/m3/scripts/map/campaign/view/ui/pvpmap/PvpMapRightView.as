package map.campaign.view.ui.pvpmap
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import map.campaign.CampaignSocketOutManager;
   import map.campaign.data.PvpWarFightInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   
   public class PvpMapRightView extends Sprite implements Disposeable
   {
      
      private var _bg:Scale9CornerImage;
      
      private var _resetBtn:BaseButton;
      
      private var _sortBtn:BaseButton;
      
      private var _integralTitleTxt:FilterFrameText;
      
      private var _integralValueTxt:FilterFrameText;
      
      private var _sortTitleTxt:FilterFrameText;
      
      private var _sortValueTxt:FilterFrameText;
      
      private var _honerValueTxt:FilterFrameText;
      
      private var _integralBg:ScaleBitmapImage;
      
      private var _scoreTitle:Bitmap;
      
      private var _honerBg:ScaleBitmapImage;
      
      private var _honerTitle:Bitmap;
      
      private var _data:PvpWarFightInfo;
      
      private var _teamBg:ScaleBitmapImage;
      
      private var _teamIcon:ScaleFrameImage;
      
      private var _teamScore:FilterFrameText;
      
      public function PvpMapRightView()
      {
         super();
         init();
         addEvent();
      }
      
      private function init() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("campaign.pvp.RightViewBg");
         addChild(_bg);
         _teamBg = ComponentFactory.Instance.creatComponentByStylename("campaign.pvp.teamBg");
         _teamIcon = ComponentFactory.Instance.creatComponentByStylename("campaign.pvp.team");
         _teamScore = ComponentFactory.Instance.creatComponentByStylename("campaign.pvp.TeamSocreTxt");
         _teamScore.text = "0";
         _teamIcon.tipData = LanguageMgr.GetTranslation("campaign.pvp.TeamScore");
         addChild(_teamBg);
         addChild(_teamIcon);
         addChild(_teamScore);
         _scoreTitle = ComponentFactory.Instance.creatBitmap("asset.campaign.pvp.ScoreAsset");
         addChild(_scoreTitle);
         _honerTitle = ComponentFactory.Instance.creatBitmap("asset.campaign.pvp.HonorIconAsset");
         addChild(_honerTitle);
         _resetBtn = ComponentFactory.Instance.creatComponentByStylename("campaign.pvp.ResetBtn");
         addChild(_resetBtn);
         _resetBtn.tipData = LanguageMgr.GetTranslation("map.campaign.view.ui.pvpmap.PvpMapRightView.reset");
         _resetBtn.isFollowMouse = false;
         _sortBtn = ComponentFactory.Instance.creatComponentByStylename("campaign.pvp.SortBtn");
         addChild(_sortBtn);
         _sortBtn.tipData = LanguageMgr.GetTranslation("map.campaign.view.ui.pvpmap.PvpMapRightView.sort");
         _sortBtn.isFollowMouse = false;
         _integralTitleTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.pvp.IntegralTitleTxt");
         addChild(_integralTitleTxt);
         _integralTitleTxt.text = "50";
         _honerValueTxt = ComponentFactory.Instance.creatComponentByStylename("campaign.pvp.HonerValueTxt");
         addChild(_honerValueTxt);
         _honerValueTxt.text = "100";
      }
      
      private function addEvent() : void
      {
         _resetBtn.addEventListener("click",__resetHandler);
         _sortBtn.addEventListener("click",__sortHandler);
      }
      
      private function removeEvent() : void
      {
         if(_resetBtn)
         {
            _resetBtn.removeEventListener("click",__resetHandler);
         }
         if(_sortBtn)
         {
            _sortBtn.removeEventListener("click",__sortHandler);
         }
      }
      
      private function __resetHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         CampaignSocketOutManager.instance.requestWarFightOrderList();
         CampaignSocketOutManager.instance.warMaxhp();
      }
      
      private function __sortHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("003");
         FrameControllerManager.instance.openControllerByInfo("pvpmap",1);
         CampaignSocketOutManager.instance.requestWarFightOrderList();
      }
      
      private function __updateHonor(param1:Event) : void
      {
         _honerValueTxt && (_honerValueTxt.text = ArmyManager.instance.thane.honer.toString());
      }
      
      public function set data(param1:PvpWarFightInfo) : void
      {
         _data = param1;
         _integralTitleTxt.text = param1.score + "";
         _honerValueTxt.text = param1.geste + "";
         _teamIcon.setFrame(_data.teamId);
         if(_data.teamId == 1)
         {
            _teamScore.text = param1.oneScore.toString();
         }
         else
         {
            _teamScore.text = param1.twoScore.toString();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_resetBtn)
         {
            _resetBtn.dispose();
         }
         _resetBtn = null;
         if(_sortBtn)
         {
            _sortBtn.dispose();
         }
         _sortBtn = null;
         if(_integralTitleTxt)
         {
            _integralTitleTxt.dispose();
         }
         _integralTitleTxt = null;
         if(_integralValueTxt)
         {
            _integralValueTxt.dispose();
         }
         _integralValueTxt = null;
         if(_sortTitleTxt)
         {
            _sortTitleTxt.dispose();
         }
         _sortTitleTxt = null;
         if(_sortValueTxt)
         {
            _sortValueTxt.dispose();
         }
         _sortValueTxt = null;
         if(_honerValueTxt)
         {
            _honerValueTxt.dispose();
         }
         _honerValueTxt = null;
         if(_integralBg)
         {
            _integralBg.dispose();
         }
         _integralBg = null;
         if(_scoreTitle)
         {
            if(_scoreTitle.parent)
            {
               _scoreTitle.parent.removeChild(_scoreTitle);
            }
            _scoreTitle.bitmapData.dispose();
         }
         _scoreTitle = null;
         if(_honerBg)
         {
            _honerBg.dispose();
         }
         _honerBg = null;
         if(_honerTitle)
         {
            if(_honerTitle.parent)
            {
               _honerTitle.parent.removeChild(_honerTitle);
            }
            _honerTitle.bitmapData.dispose();
         }
         _honerTitle = null;
         if(_teamBg)
         {
            _teamBg.dispose();
         }
         _teamBg = null;
         if(_teamIcon)
         {
            _teamIcon.dispose();
         }
         _teamIcon = null;
         if(_teamScore)
         {
            _teamScore.dispose();
         }
         _teamScore = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

