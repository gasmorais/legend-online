package outyard.titan
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.titanland.TitanlandBoosMsg;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import mvc.controler.SortController;
   import mvc.module.sort.SortData;
   import mvc.module.sort.SortModel;
   import yishi.events.NotificationEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PathManager;
   import yishi.view.community.PlayerMenu;
   
   public class OutyardTitanPlayerItem extends Component
   {
      
      private var _icon:Bitmap;
      
      private var _sortModel:SortModel;
      
      private var _nickBtn:FilterFrameText;
      
      private var _progressMc:MovieClip;
      
      private var _data:TitanlandBoosMsg;
      
      public function OutyardTitanPlayerItem()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _nickBtn = ComponentFactory.Instance.creatComponentByStylename("outyardTitanPlayerItem.nickText");
      }
      
      private function addEvent() : void
      {
         _nickBtn.addEventListener("click",__clickNickHandler);
         NotificationManager.instance.addEventListener("UPDATE_TITAN_VIEW",__updateTitanHandler);
      }
      
      private function removeEvent() : void
      {
         _nickBtn.removeEventListener("click",__clickNickHandler);
         NotificationManager.instance.removeEventListener("UPDATE_TITAN_VIEW",__updateTitanHandler);
      }
      
      public function set data(param1:TitanlandBoosMsg) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         _icon = ComponentFactory.Instance.creatBitmap("asset.outyard.register.head" + _data.job);
         _progressMc = ComponentFactory.Instance.creatCustomObject("asset.outyard.titanProgressMc");
         addChild(_icon);
         addChild(_nickBtn);
         addChild(_progressMc);
         _nickBtn.htmlText = "<a href =\'event: \'><u><b>" + _data.nickName + "</b></u></a>";
         _nickBtn.mouseEnabled = true;
         _progressMc.gotoAndStop(_data.bossHp);
      }
      
      public function get data() : TitanlandBoosMsg
      {
         return _data;
      }
      
      private function __updateTitanHandler(param1:NotificationEvent) : void
      {
         if(_data)
         {
            _progressMc.gotoAndStop(_data.bossHp);
         }
      }
      
      private function __clickNickHandler(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         param1.stopPropagation();
         param1.stopImmediatePropagation();
         SoundManager.instance.play("022");
         var _loc2_:Array = [];
         var _loc4_:SortController = FrameControllerManager.instance.sortController;
         _sortModel = _loc4_.model;
         if(_sortModel.playerFightList2 == null || _sortModel.playerFightList2.length == 0)
         {
            _loc3_ = PathManager.orderPath + "cross/fight.xml";
            _loc2_.push(_loc3_);
         }
         if(_loc2_.length > 0)
         {
            _loc4_.loadAllCrossXML(_loc2_,updateData);
         }
         else
         {
            updateData();
         }
      }
      
      private function updateData() : void
      {
         var _loc4_:SortData = null;
         var _loc3_:int = 0;
         var _loc1_:PlayerMenu = null;
         var _loc2_:Boolean = true;
         if(_sortModel.playerFightList2 && _sortModel.playerFightList2.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < _sortModel.playerFightList2.length)
            {
               _loc4_ = _sortModel.playerFightList2[_loc3_];
               if(_loc4_.orderId == _data.orderId)
               {
                  _loc1_ = new PlayerMenu(false,false,_loc2_);
                  _loc1_.setData(_loc4_);
                  _loc1_.x = StageReferance.stage.mouseX;
                  _loc1_.y = StageReferance.stage.mouseY;
                  LayerManager.Instance.addToLayer(_loc1_,7);
                  break;
               }
               _loc3_++;
            }
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_nickBtn);
         _nickBtn = null;
         ObjectUtils.disposeViolentMc(_progressMc);
         _progressMc = null;
         _sortModel = null;
         _data = null;
         super.dispose();
      }
   }
}

