package map.campaign.view.ui.duskarea
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignSocketOutManager;
   import map.campaign.data.PvpWarFightModel;
   import map.campaign.event.PvpWarFightEvent;
   import map.campaign.view.frame.duskarea.DuskAreaPointRankFrame;
   import map.campaign.view.frame.duskarea.DuskAreaSmallMapFrame;
   import map.campaign.view.frame.duskarea.IceFireWarSmallMapFrame;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.NotificationManager;
   import yishi.utils.WorldBossHelper;
   import yishi.view.frame.NewVipOpenView;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class DuskAreaSelfInfoView extends Component
   {
      
      private var _bgTop:Bitmap;
      
      private var _bg:ScaleBitmapImage;
      
      private var _mainIcon:Bitmap;
      
      private var _infoTxtImg:Bitmap;
      
      private var _pointTxtImg:Bitmap;
      
      private var _selfResTxtImg:Bitmap;
      
      private var _pointTxt:FilterFrameText;
      
      private var _selfResTxt:FilterFrameText;
      
      private var _rankBtn:IconButton;
      
      private var _mapBtn:IconButton;
      
      private var _hideBtn:BaseButton;
      
      private var _rect:Rectangle;
      
      private var _hideHeight:int = 32;
      
      private var _showHeight:int = 300;
      
      private var _isHide:Boolean = false;
      
      private var _smallMapFrame:Frame;
      
      private var _duskAreaPointRankFrame:DuskAreaPointRankFrame;
      
      private var _vipOpenView:NewVipOpenView;
      
      public function DuskAreaSelfInfoView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bgTop = ComponentFactory.Instance.creatBitmap("asset.DuskAreaSelfInfoView.bgTop");
         _bg = ComponentFactory.Instance.creatComponentByStylename("duskAreaSelfInfoView.bg");
         _infoTxtImg = ComponentFactory.Instance.creatBitmap("asset.DuskAreaSelfInfoView.infoTxtImg");
         _pointTxtImg = ComponentFactory.Instance.creatBitmap("asset.DuskAreaSelfInfoView.pointTxtImg");
         _selfResTxtImg = ComponentFactory.Instance.creatBitmap("asset.DuskAreaSelfInfoView.selfResTxtImg");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.ui.DuskAreaSelfInfoView.pointTxt");
         _pointTxt.text = "1000";
         _selfResTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.ui.DuskAreaSelfInfoView.selfResTxt");
         _selfResTxt.text = "100000";
         _rankBtn = ComponentFactory.Instance.creatComponentByStylename("duskarea.ui.DuskAreaSelfInfoView.RankBtn");
         _mapBtn = ComponentFactory.Instance.creatComponentByStylename("duskarea.ui.DuskAreaSelfInfoView.MapBtn");
         _mapBtn.tipData = [LanguageMgr.GetTranslation("map.campaign.view.ui.duskarea.DuskAreaSelfInfoView.mapBtnTips")];
         _hideBtn = ComponentFactory.Instance.creatComponentByStylename("duskarea.ui.HideBtn");
         _vipOpenView = new NewVipOpenView(15);
         addChild(_bgTop);
         addChild(_bg);
         addChild(_infoTxtImg);
         addChild(_pointTxtImg);
         addChild(_selfResTxtImg);
         addChild(_pointTxt);
         addChild(_selfResTxt);
         addChild(_rankBtn);
         addChild(_mapBtn);
         addChild(_hideBtn);
         addChild(_vipOpenView);
         _vipOpenView.x = 3;
         _vipOpenView.y = 162;
         _vipOpenView.setWordWrap();
         _rect = new Rectangle(0,0,170,140);
         updateView();
      }
      
      private function initEvent() : void
      {
         _hideBtn.addEventListener("click",onHideBtnClick);
         _rankBtn.addEventListener("click",onRankClick);
         _mapBtn.addEventListener("click",onMapClick);
         pvpWarFightModel.pvpWarFightInfo.addEventListener("PVP_WAR_FIGHT_INFO_CHAGE",updateView);
         NotificationManager.instance.addEventListener("PVP_WAR_FIGHT_ORDER_REPORT",onOrder);
      }
      
      private function removeEvent() : void
      {
         _hideBtn.removeEventListener("click",onHideBtnClick);
         _rankBtn.removeEventListener("click",onRankClick);
         _mapBtn.removeEventListener("click",onMapClick);
         pvpWarFightModel.pvpWarFightInfo.removeEventListener("PVP_WAR_FIGHT_INFO_CHAGE",updateView);
         NotificationManager.instance.removeEventListener("PVP_WAR_FIGHT_ORDER_REPORT",onOrder);
         try
         {
            StageReferance.stage.removeEventListener("keyDown",onKeyDown);
         }
         catch(e:Error)
         {
         }
      }
      
      private function onHelpClick(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("duskAreaSelfInfoView.helpFrame");
         _loc2_.show();
      }
      
      private function onKeyDown(param1:KeyboardEvent) : void
      {
         if(WorldBossHelper.checkFlameTemple(CampaignManager.instance.mapId))
         {
            return;
         }
         if(!KeyBoardRegister.instance.keyEnable)
         {
            return;
         }
         switch(int(param1.keyCode) - 77)
         {
            case 0:
               onMapClick();
         }
      }
      
      private function onMapClick(param1:MouseEvent = null) : void
      {
         if(_smallMapFrame != null && _smallMapFrame.parent != null)
         {
            _smallMapFrame.dispose();
            _smallMapFrame = null;
         }
         else if(WorldBossHelper.checkDuskArea(CampaignManager.instance.mapId))
         {
            _smallMapFrame = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaAccountFrame.DuskAreaSmallMapFrame");
            (_smallMapFrame as DuskAreaSmallMapFrame).show();
         }
         else
         {
            _smallMapFrame = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaAccountFrame.IceFireWarSmallMapFrame");
            (_smallMapFrame as IceFireWarSmallMapFrame).show();
         }
      }
      
      private function onOrder(param1:PvpWarFightEvent) : void
      {
         _duskAreaPointRankFrame = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankFrame");
         _duskAreaPointRankFrame.show();
         _duskAreaPointRankFrame.setDate(param1.data["list"]);
      }
      
      private function onRankClick(param1:MouseEvent) : void
      {
         CampaignSocketOutManager.instance.requestWarFightOrderList();
      }
      
      public function updateView(param1:Event = null) : void
      {
         _pointTxt.text = pvpWarFightModel.pvpWarFightInfo.geste.toString();
         _selfResTxt.text = pvpWarFightModel.pvpWarFightInfo.score.toString();
         if(WorldBossHelper.checkFlameTemple(CampaignManager.instance.mapId))
         {
            _mapBtn.visible = false;
            _rankBtn.x = 65;
         }
         else
         {
            _rankBtn.x = 35;
         }
         if(_mainIcon == null)
         {
            _mainIcon = ComponentFactory.Instance.creatBitmap("asset.DuskAreaSelfInfoView.teamIcon" + CampaignManager.instance.mapModel.selfMemberData.teamId);
            addChild(_mainIcon);
         }
      }
      
      private function get pvpWarFightModel() : PvpWarFightModel
      {
         return CampaignManager.instance.pvpWarFightModel;
      }
      
      private function onHideBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(param1)
         {
            param1.stopPropagation();
         }
         _isHide = !_isHide;
         if(_isHide)
         {
            _hideBtn.scaleX = -1;
            TweenLite.to(_hideBtn,0.5,{
               "x":165,
               "scaleX":-1
            });
            TweenLite.to(_bgTop,0.5,{"alpha":0});
            TweenLite.to(_infoTxtImg,0.5,{"x":75});
            TweenLite.to(_mainIcon,0.5,{"x":45});
            this.buttonMode = true;
            TweenLite.to(_rect,0.5,{
               "height":_hideHeight,
               "onUpdate":updateRec
            });
         }
         else
         {
            _hideBtn.scaleX = 1;
            TweenLite.to(_hideBtn,0.5,{
               "x":140,
               "scaleX":1
            });
            TweenLite.to(_bgTop,0.5,{"alpha":1});
            TweenLite.to(_infoTxtImg,0.5,{"x":65});
            TweenLite.to(_mainIcon,0.5,{"x":30});
            this.buttonMode = false;
            TweenLite.to(_rect,0.5,{
               "height":_showHeight,
               "onUpdate":updateRec
            });
         }
      }
      
      private function updateRec() : void
      {
         scrollRect = _rect;
      }
      
      public function get viewWidth() : Number
      {
         return _bg.width;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,4,false,false,0,3);
         StageReferance.stage.addEventListener("keyDown",onKeyDown);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bgTop);
         _bgTop = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_mainIcon);
         _mainIcon = null;
         ObjectUtils.disposeObject(_infoTxtImg);
         _infoTxtImg = null;
         ObjectUtils.disposeObject(_pointTxtImg);
         _pointTxtImg = null;
         ObjectUtils.disposeObject(_selfResTxtImg);
         _selfResTxtImg = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         ObjectUtils.disposeObject(_selfResTxt);
         _selfResTxt = null;
         ObjectUtils.disposeObject(_rankBtn);
         _rankBtn = null;
         ObjectUtils.disposeObject(_mapBtn);
         _mapBtn = null;
         ObjectUtils.disposeObject(_hideBtn);
         _hideBtn = null;
         ObjectUtils.disposeObject(_vipOpenView);
         _vipOpenView = null;
         ObjectUtils.disposeObject(_smallMapFrame);
         _smallMapFrame = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

