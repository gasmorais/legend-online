package childspiritexpedition.formation
{
   import childformation.ChildCommonFormationItemView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Stage;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.SpiritExpeditionManager;
   import mvc.module.children.ChildData;
   import mvc.module.childspiritexpedition.SpiritExpeditionChildInfo;
   import mvc.module.childspiritexpedition.SpiritExpeditionModel;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.events.PlayerEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.BaseManager;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.GameDrag;
   import yishi.view.base.ProgressCommon;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class SpiritExpeditionNSHeadItem extends Component
   {
      
      private var _back:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _enterWarImage:Image;
      
      private var _energyBar:ProgressCommon;
      
      private var _cdTxt:FilterFrameText;
      
      private var _speedBtn:BaseButton;
      
      private var _tempInfo:ChildTempInfo;
      
      private var _data:SpiritExpeditionChildInfo;
      
      private var dragView:ChildCommonFormationItemView;
      
      public var formationType:int;
      
      public var canDrag:Boolean = false;
      
      public var viewType:int;
      
      private var maxEnergy:int;
      
      private var costPoint:int;
      
      private var preMinCost:int;
      
      private var needPoint:int;
      
      public function SpiritExpeditionNSHeadItem(param1:int)
      {
         super();
         viewType = param1;
         initView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,154,63);
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.SpiritExpeditionNSHeadItem.back");
         _icon = ComponentFactory.Instance.creatCustomObject("SpiritExpeditionNSHeadItem.icon");
         _enterWarImage = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionNSHeadItem.enterWarImage");
         _energyBar = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionNSHeadItem.energyBar");
         _cdTxt = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionNSHeadItem.cdTxt");
         _speedBtn = ComponentFactory.Instance.creatComponentByStylename("SpiritExpeditionNSHeadItem.speedBtn");
         addChild(_back);
         addChild(_icon);
         addChild(_enterWarImage);
         addChild(_energyBar);
         addChild(_cdTxt);
         addChild(_speedBtn);
         _enterWarImage.visible = false;
         _enterWarImage.mouseEnabled = false;
         _energyBar.visible = false;
         _speedBtn.visible = false;
         _cdTxt.text = "";
         maxEnergy = ConfigInfoManager.instance.getExpeditionMaxEnergy();
         preMinCost = ConfigInfoManager.instance.getExpeditionCdMinute();
      }
      
      private function addEvent() : void
      {
         _icon.addEventListener("mouseDown",__mouseDownHandler);
         _icon.addEventListener("mouseUp",__mouseUpHandler);
         playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__updateCdTimeHandler);
         _speedBtn.addEventListener("click",__addEnergyHandler);
      }
      
      private function removeEvent() : void
      {
         if(_icon)
         {
            _icon.removeEventListener("mouseDown",__mouseDownHandler);
            _icon.removeEventListener("mouseUp",__mouseUpHandler);
            _icon.removeEventListener("mouseMove",__mouseMoveHandler);
         }
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__updateCdTimeHandler);
         if(_speedBtn)
         {
            _speedBtn.removeEventListener("click",__addEnergyHandler);
         }
      }
      
      private function __addEnergyHandler(param1:MouseEvent) : void
      {
         if(!data || data.energy > 0)
         {
            return;
         }
         var _loc2_:Array = ConfigInfoManager.instance.getExpeditionCdPoint();
         costPoint = Math.ceil(data.leftCount / 60 / int(_loc2_[0])) * int(_loc2_[1]);
         var _loc3_:String = LanguageMgr.GetTranslation("SpiritExpeditionNSHeadItem.speedBtn.content",costPoint);
         LogicUtils.alert(_loc3_,"SIMPLE_ALERT",suerSpeedUpHandler);
      }
      
      private function suerSpeedUpHandler(param1:Boolean, param2:Boolean) : void
      {
         if(!param1)
         {
            return;
         }
         if(!LogicUtils.judgePointEnoughToShowPay(costPoint,false))
         {
            return;
         }
         SpiritExpeditionManager.instance.sendExpeditionClearCd(data.childId);
      }
      
      private function __updateCdTimeHandler(param1:PlayerEvent) : void
      {
         updateCdTime();
      }
      
      private function __mouseDownHandler(param1:MouseEvent) : void
      {
         if(!canDrag)
         {
            return;
         }
         _icon.addEventListener("mouseMove",__mouseMoveHandler);
      }
      
      private function __mouseMoveHandler(param1:MouseEvent) : void
      {
         if(!canDrag)
         {
            return;
         }
         _icon.removeEventListener("mouseMove",__mouseMoveHandler);
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         clearTimeout(BaseManager.delayId);
         BaseManager.delayId = setTimeout(beginDrag,100,"down");
      }
      
      private function __mouseUpHandler(param1:MouseEvent) : void
      {
         if(!canDrag)
         {
            return;
         }
         _icon.removeEventListener("mouseMove",__mouseMoveHandler);
         if(DragManager.getInstance().isDraging)
         {
            return;
         }
         clearTimeout(BaseManager.delayId);
         BaseManager.delayId = setTimeout(beginDrag,100,"click");
      }
      
      private function beginDrag(param1:String) : void
      {
         if(model.enterWarList.length >= 3)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("childpve.ChildFormationFrame.posFull"));
            return;
         }
         dragView = new ChildCommonFormationItemView();
         dragView.data = data.childData;
         dragView.isDrag = true;
         dragView.mouseChildren = dragView.mouseEnabled = false;
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(this,{
            "icon":dragView,
            "type":param1
         });
         _loc2_.data = data.childData;
         _loc2_.onDrop = dragBack;
         _loc2_.dropChecks = [ChildCommonFormationItemView,Stage];
         this.canDrag = false;
         NotificationManager.instance.sendNotification("START_DRAG",this);
      }
      
      private function dragBack(param1:GameDrag) : void
      {
         var _loc2_:ChildCommonFormationItemView = null;
         if(param1.dropTarget != param1.dragIcon && param1.dropTarget is ChildCommonFormationItemView)
         {
            _loc2_ = param1.dropTarget as ChildCommonFormationItemView;
         }
         if(param1.dragIcon)
         {
            ObjectUtils.disposeObject(param1.dragIcon);
         }
         dragView = null;
         if(_loc2_)
         {
            _loc2_.data = param1.data as ChildData;
         }
         else
         {
            this.canDrag = true;
         }
         NotificationManager.instance.sendNotification("END_DRAG",this);
      }
      
      public function get tempInfo() : ChildTempInfo
      {
         return _tempInfo;
      }
      
      public function set tempInfo(param1:ChildTempInfo) : void
      {
         _tempInfo = param1;
         if(!tempInfo)
         {
            _icon.icon = null;
            return;
         }
         _icon.icon = PathManager.info.ResourcePath + "icon" + tempInfo.Icon;
         data = model.getChildInfoByJob(tempInfo.JobType);
      }
      
      public function get data() : SpiritExpeditionChildInfo
      {
         return _data;
      }
      
      public function set data(param1:SpiritExpeditionChildInfo) : void
      {
         _data = param1;
         removeEvent();
         if(_data)
         {
            addEvent();
            _energyBar.value = data.energy / maxEnergy;
            _energyBar.tipData = LanguageMgr.GetTranslation("SpiritExpeditionNSHeadItem.energyBar.tipData",data.energy,maxEnergy);
            _icon.tipData = data.childData;
            if(data.leftCount > 0 || data.energy <= 0)
            {
               _icon.filters = [UIFilter.getGrayFilter()];
               _speedBtn.visible = true;
               _energyBar.visible = false;
               updateCdTime();
            }
            else
            {
               _speedBtn.visible = false;
               _energyBar.visible = true;
               _icon.filters = [];
            }
            canDrag = data.pos <= 0 && data.energy > 0;
            _enterWarImage.visible = data.pos > 0;
         }
         else
         {
            _energyBar.tipData = null;
            canDrag = false;
            _icon.filters = [UIFilter.getGrayFilter()];
         }
         refreshTypeView();
      }
      
      private function refreshTypeView() : void
      {
         if(viewType == 2)
         {
            canDrag = false;
            _speedBtn.visible = false;
            if(data)
            {
               if(data.energy > 0)
               {
                  _energyBar.visible = true;
               }
               if(data.childData)
               {
                  _icon.tipData = data.childData;
                  _icon.icon = PathManager.info.ResourcePath + "icon" + data.childData.childTempInfo.Icon;
               }
            }
            else
            {
               _icon.icon = null;
               _energyBar.visible = false;
               _enterWarImage.visible = false;
               _cdTxt.text = "";
            }
         }
      }
      
      private function updateCdTime() : void
      {
         if(data && data.leftCount > 0)
         {
            _cdTxt.text = DateFormatter.getConsortiaCountDate(data.leftCount);
         }
         else
         {
            _cdTxt.text = "";
         }
      }
      
      private function get model() : SpiritExpeditionModel
      {
         return SpiritExpeditionManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_energyBar);
         _energyBar = null;
         ObjectUtils.disposeObject(_cdTxt);
         _cdTxt = null;
         ObjectUtils.disposeObject(_speedBtn);
         _speedBtn = null;
         ObjectUtils.disposeObject(_enterWarImage);
         _enterWarImage = null;
         ObjectUtils.disposeObject(dragView);
         dragView = null;
         super.dispose();
      }
   }
}

