package map.internals.view.displaye
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.campaign.CampaignReportMsg;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.DateFormatter;
   import yishi.utils.IconFactory;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseIconView;
   import yishi.view.tools.SimpleMovie;
   
   public class CampaignResultView extends Sprite implements Disposeable, IManualSize
   {
      
      private static const NUM:Number = 0.0001;
      
      private var _mc:MovieClip;
      
      private var _figure:MovieClip;
      
      private var _numberBit1:BitmapData;
      
      private var _numberBit2:BitmapData;
      
      private var _vipNumBit:BitmapData;
      
      private var _tenThousandView:Bitmap;
      
      private var _orderView:Bitmap;
      
      private var _petIcon:BaseIconView;
      
      private var _msg:CampaignReportMsg;
      
      public function CampaignResultView(param1:CampaignReportMsg)
      {
         super();
         _msg = param1;
      }
      
      public function show() : void
      {
         CheckUIModuleUtil.instance.tryCall("clearance",init);
      }
      
      private function initPetIcon() : void
      {
         _petIcon = ComponentFactory.Instance.creatCustomObject("battle.PetIcon");
         if(playerInfo.enterWarPet)
         {
            _petIcon.icon = IconFactory.getPetHeadSmallIcon(playerInfo.enterWarPet.templateId);
         }
      }
      
      private function init() : void
      {
         _numberBit1 = ComponentFactory.Instance.creatBitmapData("asset.campaign.Number1");
         _numberBit2 = ComponentFactory.Instance.creatBitmapData("asset.campaign.Number2");
         _vipNumBit = ComponentFactory.Instance.creatBitmapData("asset.campaign.Number3");
         _tenThousandView = ComponentFactory.Instance.creatBitmap("asset.campaign.tenThousand");
         _orderView = ComponentFactory.Instance.creatBitmap("asset.campaign.orderUnit");
         var _loc11_:int = _msg.failedCount;
         var _loc7_:int = _msg.endBossTime;
         var _loc2_:int = _msg.endBossAppraisal;
         var _loc3_:int = _msg.failedAppraisal;
         var _loc8_:int = _msg.teamJoin;
         var _loc6_:int = _msg.friendJoin;
         var _loc4_:int = _msg.propJoin;
         var _loc9_:int = _msg.vipJoin;
         var _loc1_:int = _msg.otherJoin;
         var _loc10_:int = _msg.totalGp;
         var _loc12_:int = int(_msg.petGp > 0 ? _msg.petGp : 0);
         var _loc5_:int = _msg.totalAppraisal;
         if(playerInfo.enterWarPet)
         {
            initPetIcon();
         }
         initData(_loc7_,_loc2_,_loc11_,_loc3_,_loc8_,_loc6_,_loc4_,_loc1_,_loc9_,_loc10_,_loc12_,_loc5_);
         _msg = null;
         LayerManager.Instance.addToLayer(this,6,true,true,1);
      }
      
      public function initData(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:int, param12:int) : void
      {
         _mc = ComponentFactory.Instance.creatCustomObject("campaign.Resultmc");
         _mc["content_1"]["bossTimeTxt"].text = DateFormatter.getCountDateByMS(param1);
         NumberViewUtils.refreshAddStrValue(param3,_mc["content_1"]["dieNum"],_numberBit1,25,25,15,25,"0123456789:",_orderView);
         _mc["content_1"]["bossTime"].text = LanguageMgr.GetTranslation("campaign.Resultmc.bossTime",DateFormatter.getCountDateByMS(campaignTemp.StandSecond));
         _mc["content_1"]["dieS"].text = LanguageMgr.GetTranslation("campaign.Resultmc.dieS",0);
         _mc["content_2"]["killBossTimG"].gotoAndStop(param2);
         _mc["content_2"]["dieNumG"].gotoAndStop(param4);
         NumberViewUtils.refreshValue(param5,_mc["content_3"]["group"],_numberBit1,25,25,15,25,"0123456789:");
         NumberViewUtils.refreshValue(param6,_mc["content_3"]["friends"],_numberBit1,25,25,15,25,"0123456789:");
         NumberViewUtils.refreshValue(param7,_mc["content_3"]["prop"],_numberBit1,25,25,15,25,"0123456789:");
         NumberViewUtils.refreshValue(param8,_mc["content_3"]["other"],_numberBit1,25,25,15,25,"0123456789:");
         NumberViewUtils.refreshValue(param10,_mc["getTotalExp"]["exp_mc"],_numberBit2,24,30,16,24,"0123456789");
         NumberViewUtils.refreshValue(param9,_mc["getTotalExp"]["vip_exp"]["vip_num"],_vipNumBit,24,30,15,24,"0123456789");
         addProfileMc(param12);
         var _loc13_:SimpleMovie = new SimpleMovie(_mc,callBack,1);
         addChild(_loc13_);
      }
      
      private function isMax(param1:int) : Boolean
      {
         if(param1 * 0.0001 >= 100)
         {
            return true;
         }
         return false;
      }
      
      private function callBack() : void
      {
         dispose();
      }
      
      private function addProfileMc(param1:int) : void
      {
         var _loc2_:MovieClip = null;
         switch(param1 - 1)
         {
            case 0:
               _loc2_ = ComponentFactory.Instance.creat("asset.campaign.ProfileMCD");
               break;
            case 1:
               _loc2_ = ComponentFactory.Instance.creat("asset.campaign.ProfileMCC");
               break;
            case 2:
               _loc2_ = ComponentFactory.Instance.creat("asset.campaign.ProfileMCB");
               break;
            case 3:
               _loc2_ = ComponentFactory.Instance.creat("asset.campaign.ProfileMCA");
               break;
            case 4:
               _loc2_ = ComponentFactory.Instance.creat("asset.campaign.ProfileMCS");
               break;
            case 5:
               _loc2_ = ComponentFactory.Instance.creat("asset.campaign.ProfileMCSS");
               break;
            case 6:
               _loc2_ = ComponentFactory.Instance.creat("asset.campaign.ProfileMCSSS");
         }
         _mc["profile_mc"].addChild(_loc2_);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get campaignTemp() : CampaignTemplate
      {
         return TempleteManager.instance.getCampaignTemplateById(CampaignManager.instance.mapModel.mapTempInfo.CampaignId);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_numberBit1);
         _numberBit1 = null;
         ObjectUtils.disposeObject(_numberBit2);
         _numberBit2 = null;
         ObjectUtils.disposeObject(_vipNumBit);
         _vipNumBit = null;
         ObjectUtils.disposeObject(_tenThousandView);
         _tenThousandView = null;
         ObjectUtils.disposeObject(_orderView);
         _orderView = null;
         ObjectUtils.disposeObject(_petIcon);
         _petIcon = null;
         ObjectUtils.disposeViolentMc(_mc);
         _mc = null;
         ObjectUtils.disposeViolentMc(_figure);
         _figure = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _mc = null;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,200,175);
      }
   }
}

