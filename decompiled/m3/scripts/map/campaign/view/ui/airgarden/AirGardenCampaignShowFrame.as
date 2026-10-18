package map.campaign.view.ui.airgarden
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import managers.MountsManager;
   import map.internals.data.CampaignNode;
   import mvc.ModuleFrameInfo;
   import mvc.module.children.ChildData;
   import mvc.module.pet.PetData;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.base.PageBar;
   
   public class AirGardenCampaignShowFrame extends Frame implements IManualSize
   {
      
      private var _itemBox:SimpleTileList;
      
      private var _pageBar:PageBar;
      
      private var itemList:Vector.<AirGardenCampaignShowItem>;
      
      private var pageCount:int = 6;
      
      public function AirGardenCampaignShowFrame()
      {
         super();
         initView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,755,605);
      }
      
      private function initView() : void
      {
         _itemBox = ComponentFactory.Instance.creatCustomObject("AirGardenCampaignShowFrame.SimpleTileList",[3]);
         _pageBar = ComponentFactory.Instance.creatComponentByStylename("AirGardenCampaignShowFrame.pageBar");
         addToContent(_itemBox);
         addToContent(_pageBar);
         this.mouseEnabled = false;
      }
      
      private function initListView(param1:int, param2:CampaignNode) : void
      {
         var _loc5_:int = 0;
         var _loc4_:AirGardenCampaignShowItem = null;
         var _loc6_:Array = getShowListByType(param1);
         _pageBar.setAutoPagingData(_loc6_,pageCount);
         _pageBar.setCurPage(1);
         var _loc3_:Array = _pageBar.getCurPageDatas();
         itemList = new Vector.<AirGardenCampaignShowItem>();
         _loc5_ = 0;
         while(_loc5_ < pageCount)
         {
            _loc4_ = new AirGardenCampaignShowItem(param2);
            _loc4_.data = _loc3_.length > _loc5_ ? _loc3_[_loc5_] : null;
            _itemBox.addChild(_loc4_);
            itemList.push(_loc4_);
            _loc5_++;
         }
         _itemBox.commitChanges();
      }
      
      private function addEvent() : void
      {
         _pageBar.addEventListener("change",_pageChangeHandler);
         addEventListener("response",__frameResponse);
      }
      
      private function removeEvent() : void
      {
         if(_pageBar)
         {
            _pageBar.removeEventListener("change",_pageChangeHandler);
         }
         removeEventListener("response",__frameResponse);
      }
      
      private function _pageChangeHandler(param1:Event) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:AirGardenCampaignShowItem = null;
         var _loc1_:Array = _pageBar.getCurPageDatas();
         _loc3_ = 0;
         while(_loc3_ < pageCount)
         {
            _loc2_ = itemList[_loc3_];
            _loc2_.data = _loc1_.length > _loc3_ ? _loc1_[_loc3_] : null;
            _loc3_++;
         }
         _itemBox.commitChanges();
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         var _loc3_:int = 0;
         var _loc2_:CampaignNode = null;
         if(param1 && param1.frameData)
         {
            _loc3_ = int(param1.frameData.type);
            _loc2_ = param1.frameData.node;
         }
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         this.titleText = LanguageMgr.GetTranslation("AirGardenCampaignShowFrame.title.text" + _loc3_);
         initListView(_loc3_,_loc2_);
         addEvent();
      }
      
      private function getShowListByType(param1:int) : Array
      {
         var _loc5_:ChildData = null;
         var _loc3_:PetData = null;
         var _loc2_:Array = [];
         var _loc4_:SimpleDictionary = new SimpleDictionary(true);
         if(param1 == 1)
         {
            for each(var _loc6_:ChildData in childList)
            {
               if(!_loc4_[param1 + "_" + _loc6_.job])
               {
                  _loc4_.add(param1 + "_" + _loc6_.job,_loc6_);
               }
               else
               {
                  _loc5_ = _loc4_[param1 + "_" + _loc6_.job];
                  if(_loc6_.growthGrade > _loc5_.growthGrade)
                  {
                     _loc4_.add(param1 + "_" + _loc6_.job,_loc6_);
                  }
               }
            }
            _loc2_ = _loc4_.getList();
            _loc2_.sortOn("growthGrade",16);
         }
         else if(param1 == 2)
         {
            _loc2_ = mountList;
         }
         else if(param1 == 3)
         {
            for each(var _loc7_:PetData in petList)
            {
               if(!_loc4_[param1 + "_" + _loc7_.template.SonType])
               {
                  _loc4_.add(param1 + "_" + _loc7_.template.SonType,_loc7_);
               }
               else
               {
                  _loc3_ = _loc4_[param1 + "_" + _loc7_.template.SonType];
                  if(_loc7_.temQuality > _loc3_.temQuality)
                  {
                     _loc4_.add(param1 + "_" + _loc7_.template.SonType,_loc7_);
                  }
               }
            }
            _loc2_ = _loc4_.getList();
            _loc2_.sortOn("temQuality",16);
         }
         return _loc2_;
      }
      
      private function get petList() : Array
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo.petList;
      }
      
      private function get childList() : Vector.<ChildData>
      {
         return ChildManager.instance.model.childList;
      }
      
      private function get mountList() : Array
      {
         return MountsManager.instance.avatarList.data.getList();
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
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemBox);
         _itemBox = null;
         ObjectUtils.disposeObject(_pageBar);
         _pageBar = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

