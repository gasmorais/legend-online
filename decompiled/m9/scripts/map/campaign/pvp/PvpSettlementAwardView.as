package map.campaign.pvp
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.GradientText;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.PvpWarFightModel;
   import map.campaign.data.WarFightOrderInfo;
   
   public class PvpSettlementAwardView extends Sprite implements Disposeable
   {
      
      private var _bg3:Bitmap;
      
      private var _awardMax:Image;
      
      private var _awardTitle:Bitmap;
      
      private var _symbolBit:Bitmap;
      
      private var _honorBit:Image;
      
      private var _symbolIIBit:Bitmap;
      
      private var _awardTxt:GradientText;
      
      private var _honorTxt:GradientText;
      
      public function PvpSettlementAwardView()
      {
         super();
         init();
         this.addEventListener("addedToStage",__addToStageHandler);
      }
      
      private function init() : void
      {
         var _loc2_:int = 0;
         _bg3 = ComponentFactory.Instance.creatBitmap("asset.campaign.pvp.BattlerResultBg3");
         addChild(_bg3);
         _awardMax = ComponentFactory.Instance.creatComponentByStylename("asset.pvpmap.MaxAwardImage");
         addChild(_awardMax);
         _awardMax.tipData = LanguageMgr.GetTranslation("map.campaign.pvp.PvpSettlementAwardView.awardMax.tipData");
         _awardMax.isFollowMouse = false;
         _awardTitle = ComponentFactory.Instance.creatBitmap("asset.pvpmap.AwardAsset");
         addChild(_awardTitle);
         _symbolBit = ComponentFactory.Instance.creatBitmap("asset.pvpmap.SymbolAsset");
         addChild(_symbolBit);
         _awardTxt = ComponentFactory.Instance.creatComponentByStylename("pvpmap.sortitem.AwardTxt");
         addChild(_awardTxt);
         _symbolIIBit = ComponentFactory.Instance.creatBitmap("asset.pvpmap.SymbolAsset");
         addChild(_symbolIIBit);
         _symbolIIBit.x = 362;
         _symbolIIBit.y = 325;
         _honorBit = ComponentFactory.Instance.creatComponentByStylename("asset.pvpmap.HonorIconImage");
         addChild(_honorBit);
         _honorBit.tipData = LanguageMgr.GetTranslation("map.campaign.pvp.PvpSettlementAwardView.honorBit.tipData");
         _honorBit.isFollowMouse = false;
         _honorTxt = ComponentFactory.Instance.creatComponentByStylename("pvpmap.sortitem.OverHonorTxt");
         addChild(_honorTxt);
         var _loc1_:PvpWarFightModel = CampaignManager.instance.pvpWarFightModel;
         if(_loc1_ && _loc1_.fightReportInfo)
         {
            _loc2_ = int(_loc1_.fightReportInfo.teamCount);
            _loc2_ = int(_loc2_ > 0 ? _loc2_ : 0);
         }
         var _loc3_:WarFightOrderInfo = _loc1_.findSelfInfo();
         if(_loc3_)
         {
            _awardTxt.text = "" + _loc3_.medal;
            _honorTxt.text = "" + _loc3_.honner;
         }
      }
      
      private function __addToStageHandler(param1:Event) : void
      {
         var _loc3_:WarFightOrderInfo = null;
         var _loc2_:PvpWarFightModel = CampaignManager.instance.pvpWarFightModel;
         if(_loc2_ && _loc2_.fightReportInfo)
         {
            _loc3_ = _loc2_.findSelfInfo();
            if(_loc3_)
            {
               _awardTxt.text = "" + _loc3_.medal;
               _honorTxt.text = "" + _loc3_.honner;
            }
         }
      }
      
      public function dispose() : void
      {
         this.removeEventListener("addedToStage",__addToStageHandler);
         if(_bg3)
         {
            _bg3.bitmapData.dispose();
         }
         _bg3 = null;
         if(_awardMax)
         {
            _awardMax.dispose();
         }
         _awardMax = null;
         if(_awardTitle)
         {
            _awardTitle.bitmapData.dispose();
         }
         _awardTitle = null;
         if(_symbolBit)
         {
            _symbolBit.bitmapData.dispose();
         }
         _symbolBit = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

