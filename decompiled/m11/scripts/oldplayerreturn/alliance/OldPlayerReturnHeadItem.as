package oldplayerreturn.alliance
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.allianceregression.SimplePlayerInfoMsg;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import mvc.module.oldplayerreturn.OldPlayerReturnModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.RequestInfoEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.OldPlayerReturnManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class OldPlayerReturnHeadItem extends Component implements ISelectable
   {
      
      private var _btn:IconButton;
      
      private var _view:BaseIconView;
      
      private var _selectedBg:Bitmap;
      
      private var _selected:Boolean = false;
      
      private var _data:SimplePlayerInfoMsg;
      
      private var _menu:OldPlayerReturnHeadMenu;
      
      private var _isBinding:Boolean = false;
      
      public function OldPlayerReturnHeadItem()
      {
         super();
         initView();
         addEvent();
         selected = false;
      }
      
      private function initView() : void
      {
         _btn = ComponentFactory.Instance.creatComponentByStylename("oldPlayerReturnHeadItem.btn");
         _view = ComponentFactory.Instance.creatCustomObject("oldPlayerReturnHeadItem.view");
         _selectedBg = ComponentFactory.Instance.creatBitmap("asset.OldPlayerReturnHeadItem.selectedBg");
         addChild(_btn);
         addChild(_view);
         addChild(_selectedBg);
         _btn.visible = !model.isReturnPlayer;
      }
      
      private function addEvent() : void
      {
         _btn.addEventListener("click",__btnClickHandler);
         addEventListener("click",__itemClickHandler);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",__btnClickHandler);
         removeEventListener("click",__itemClickHandler);
      }
      
      private function __getInfoHandler(param1:RequestInfoEvent) : void
      {
         PlayerManager.instance.removeEventListener("REQUEST_SIMPLEANDSNS_INFO",__getInfoHandler);
         if(param1.orientation != 3)
         {
            return;
         }
         var _loc2_:Point = this.parent.localToGlobal(new Point(this.x,this.y));
         _menu = new OldPlayerReturnHeadMenu(_isBinding);
         _menu.setData(param1.data);
         _menu.x = _loc2_.x - _menu.width;
         _menu.y = _loc2_.y - _menu.height > 0 ? _loc2_.y - _menu.height : 0;
         LayerManager.Instance.addToLayer(_menu,7);
      }
      
      private function __itemClickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         var _loc2_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.userId);
         if(_data.userId == _loc2_)
         {
            return;
         }
         PlayerManager.instance.addEventListener("REQUEST_SIMPLEANDSNS_INFO",__getInfoHandler);
         PlayerManager.instance.sendRequestSimpleAndSnsInfo(_data.userId,3);
      }
      
      private function __btnClickHandler(param1:MouseEvent) : void
      {
         if(_view.icon)
         {
            return;
         }
         OldPlayerReturnManager.instance.sendSearch();
         FrameControllerManager.instance.openControllerByInfo("oldplayerreturn",3);
      }
      
      public function get data() : SimplePlayerInfoMsg
      {
         return _data;
      }
      
      public function set data(param1:SimplePlayerInfoMsg) : void
      {
         _data = param1;
         if(!_data)
         {
            _view.icon = null;
            return;
         }
         var _loc2_:String = IconFactory.getPlayerIcon(param1.pics,"head");
         _view.icon = _loc2_;
      }
      
      public function set isBinding(param1:Boolean) : void
      {
         _isBinding = param1;
      }
      
      public function refreshSelf() : void
      {
         var _loc1_:String = IconFactory.getPlayerIcon(thane.snsInfo.headId,"head");
         _view.icon = _loc1_;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         _selectedBg.visible = _selected && _view.icon;
      }
      
      private function get model() : OldPlayerReturnModel
      {
         return OldPlayerReturnManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_view);
         _view = null;
         ObjectUtils.disposeObject(_selectedBg);
         _selectedBg = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

