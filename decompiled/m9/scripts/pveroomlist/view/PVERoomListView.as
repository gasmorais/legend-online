package pveroomlist.view
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.PVERoomListEvent;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.PVERoomListControler;
   import mvc.module.pveroomlist.PVERoomListModel;
   import yishi.datas.templates.CampaignTemplate;
   import yishi.manager.CampaignTemplateManager;
   import yishi.manager.FrameControllerManager;
   import yishi.view.component.TileContainer;
   import yishi.view.tips.MessageTipManager;
   
   public class PVERoomListView extends Component
   {
      
      private static const ROOM_LIST_CAPICITY:int = 6;
      
      private var _back1:Scale9CornerImage;
      
      private var _back:Bitmap;
      
      private var _back2:Image;
      
      private var _filterBack:ScaleBitmapImage;
      
      private var _filterTxt:Bitmap;
      
      private var _combox:ComboBox;
      
      private var _preBtn:IconButton;
      
      private var _nextBtn:IconButton;
      
      private var _refreshBtn:BaseButton;
      
      private var _listContain:TileContainer;
      
      public function PVERoomListView()
      {
         super();
         initView();
         initList();
         initCombox();
         initEvent();
         __refreshHandler(null);
      }
      
      private function initView() : void
      {
         _back1 = ComponentFactory.Instance.creatComponentByStylename("pveroomlist.RoomListBack1");
         _back = ComponentFactory.Instance.creatBitmap("asset.pveroomlist.RoomListBack");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("pveroomlist.RoomListBack2");
         _filterBack = ComponentFactory.Instance.creatComponentByStylename("pveroomlist.FilterBackImage");
         _filterTxt = ComponentFactory.Instance.creatBitmap("asset.pveroomlist.FilterTxt");
         _combox = ComponentFactory.Instance.creatComponentByStylename("pveroomlist.Combox");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("pveroomlist.PreBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("pveroomlist.NextBtn");
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("pveroomlist.RefreshBtn");
         _listContain = new TileContainer();
         addChild(_back1);
         addChild(_back);
         addChild(_back2);
         addChild(_filterBack);
         addChild(_filterTxt);
         addChild(_combox);
         addChild(_preBtn);
         addChild(_nextBtn);
         addChild(_listContain);
         _listContain.rowCount = 2;
         _listContain.columnCount = 3;
         _listContain.paddingH = 5;
         _listContain.paddingV = -15;
         _listContain.width = 800;
      }
      
      private function initList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PVERoomItem = null;
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("pveroomlist.PVERoomItem");
            _listContain.appendItem(_loc1_);
            _loc2_++;
         }
      }
      
      private function initCombox() : void
      {
         var _loc4_:int = 0;
         var _loc5_:Array = CampaignTemplateManager.instance.getMutiCampaignList();
         var _loc3_:Array = CampaignTemplateManager.instance.getActiveCampaignList();
         var _loc1_:Array = CampaignTemplateManager.instance.getWeekCampaignList();
         _loc5_ = formatCampaignList(_loc5_);
         _loc3_ = formatActiveCampaignList(_loc3_);
         _loc1_ = formatWeekCampaignList(_loc1_);
         _combox.beginChanges();
         _combox.selctedPropName = "formatText";
         var _loc2_:VectorListModel = _combox.listPanel.vectorListModel;
         _loc2_.clear();
         _loc2_.append({
            "CampaignId":0,
            "CampaignName":LanguageMgr.GetTranslation("yishi.view.base.CampaignListCellAdapter.allFB")
         });
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            _loc2_.append(_loc5_[_loc4_]);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc2_.append(_loc3_[_loc4_]);
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc1_.length)
         {
            _loc2_.append(_loc1_[_loc4_]);
            _loc4_++;
         }
         _combox.listPanel.list.updateListView();
         _combox.commitChanges();
      }
      
      private function formatCampaignList(param1:Array) : Array
      {
         var _loc3_:Object = null;
         var _loc4_:Array = [];
         for each(var _loc2_:CampaignTemplate in param1)
         {
            _loc3_ = {};
            _loc3_.CampaignId = _loc2_.CampaignId;
            _loc3_.CampaignName = _loc2_.CampaignName + "(" + LanguageMgr.GetTranslation("public.level4_space",_loc2_.MinLevel + "-" + _loc2_.MaxLevel) + ")";
            _loc4_.push(_loc3_);
         }
         return _loc4_;
      }
      
      private function formatActiveCampaignList(param1:Array) : Array
      {
         var _loc3_:Object = null;
         var _loc4_:Array = [];
         for each(var _loc2_:CampaignTemplate in param1)
         {
            _loc3_ = {};
            _loc3_.CampaignId = _loc2_.CampaignId;
            _loc3_.CampaignName = _loc2_.CampaignName + "(" + LanguageMgr.GetTranslation("public.level4_space",_loc2_.MinLevel + "-" + _loc2_.MaxLevel) + ")" + LanguageMgr.GetTranslation("public.Activity");
            _loc4_.push(_loc3_);
         }
         return _loc4_;
      }
      
      private function formatWeekCampaignList(param1:Array) : Array
      {
         var _loc3_:Object = null;
         var _loc4_:Array = [];
         for each(var _loc2_:CampaignTemplate in param1)
         {
            _loc3_ = {};
            _loc3_.CampaignId = _loc2_.CampaignId;
            _loc3_.CampaignName = _loc2_.CampaignName + "(" + LanguageMgr.GetTranslation("public.level") + _loc2_.MinLevel + "-" + _loc2_.MaxLevel + ")";
            _loc4_.push(_loc3_);
         }
         return _loc4_;
      }
      
      private function initEvent() : void
      {
         _preBtn.addEventListener("click",__refreshRoomListHandler);
         _nextBtn.addEventListener("click",__refreshRoomListHandler);
         _refreshBtn.addEventListener("click",__refreshRoomListHandler);
         _combox.listPanel.list.addEventListener("listItemClick",__selectedCampaignChange);
         model.addEventListener("REFRESH_ROOM_LIST",__refreshHandler);
      }
      
      private function removeEvent() : void
      {
         _preBtn.removeEventListener("click",__refreshRoomListHandler);
         _nextBtn.removeEventListener("click",__refreshRoomListHandler);
         _refreshBtn.removeEventListener("click",__refreshRoomListHandler);
         _combox.listPanel.list.removeEventListener("listItemClick",__selectedCampaignChange);
         model.removeEventListener("REFRESH_ROOM_LIST",__refreshHandler);
      }
      
      private function __refreshRoomListHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         control.requestRoomInfo();
      }
      
      private function __refreshHandler(param1:PVERoomListEvent) : void
      {
         var _loc2_:PVERoomItem = null;
         var _loc4_:int = 0;
         var _loc3_:int = int(_listContain.numChildren);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _listContain.getChildAt(_loc4_) as PVERoomItem;
            if(model.roomList.length > _loc4_)
            {
               _loc2_.data = model.roomList[_loc4_];
            }
            else
            {
               _loc2_.data = null;
            }
            _loc4_++;
         }
      }
      
      private function __selectedCampaignChange(param1:ListItemEvent) : void
      {
         control.model.searchId = param1.cellValue.CampaignId;
         control.requestRoomInfo();
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("pveroomlist.view.PVERoomSearchView.command01"));
      }
      
      private function get model() : PVERoomListModel
      {
         return FrameControllerManager.instance.pveRoomListControler.model;
      }
      
      private function get control() : PVERoomListControler
      {
         return FrameControllerManager.instance.pveRoomListControler;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_back1)
         {
            _back1.dispose();
         }
         _back1 = null;
         if(_back2)
         {
            _back2.dispose();
         }
         _back2 = null;
         ObjectUtils.disposeObject(_filterBack);
         _filterBack = null;
         ObjectUtils.disposeObject(_filterTxt);
         _filterTxt = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         if(_combox)
         {
            _combox.dispose();
         }
         _combox = null;
         if(_preBtn)
         {
            _preBtn.dispose();
         }
         _preBtn = null;
         if(_nextBtn)
         {
            _nextBtn.dispose();
         }
         _nextBtn = null;
         if(_refreshBtn)
         {
            _refreshBtn.dispose();
         }
         _refreshBtn = null;
         if(_listContain)
         {
            _listContain.dispose();
         }
         _listContain = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

