package customizedvip
{
   import battle.utils.Helpers;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.CustomizedVipManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.customizedvip.CustomizedVipBoxInfo;
   import mvc.module.customizedvip.CustomizedVipModel;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   
   public class CustomizedVipFrame extends Frame
   {
      
      private var _bg:Bitmap;
      
      private var _itemHbox:HBox;
      
      private var _addImageHbox:HBox;
      
      private var _arrow:Image;
      
      private var _rewardPanel:ScrollPanel;
      
      private var _rewardTile:SimpleTileList;
      
      private var _sureBtn:IconButton;
      
      private var _data:CustomizedVipBoxInfo;
      
      private var itemList:Vector.<CustomizedVipRewardItem>;
      
      private var index:int;
      
      public function CustomizedVipFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.CustomizedVipFrame.bg");
         _addImageHbox = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipFrame.addImageHbox");
         _itemHbox = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipFrame.itemHbox");
         _rewardPanel = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipFrame.rewardPanel");
         _rewardTile = ComponentFactory.Instance.creatCustomObject("CustomizedVipFrame.rewardTile",[6]);
         _sureBtn = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipFrame.sureBtn");
         _arrow = ComponentFactory.Instance.creatComponentByStylename("CustomizedVipFrame.arrow");
         addToContent(_bg);
         addToContent(_addImageHbox);
         addToContent(_itemHbox);
         addToContent(_arrow);
         addToContent(_rewardPanel);
         addToContent(_sureBtn);
         _rewardPanel.setView(_rewardTile);
      }
      
      private function initItemView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:CustomizedVipRewardItem = null;
         var _loc2_:Bitmap = null;
         itemList = new Vector.<CustomizedVipRewardItem>();
         var _loc3_:Array = Helpers.getKeyList(data.customizedItemDic);
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc1_ = new CustomizedVipRewardItem(2,_loc4_);
            _loc1_.boxInfo = data;
            if(model.frameSelectDic[data.type])
            {
               _loc1_.data = model.frameSelectDic[data.type][_loc3_[_loc4_]];
            }
            else
            {
               _loc1_.data = null;
            }
            _itemHbox.addChild(_loc1_);
            itemList.push(_loc1_);
            if(_loc4_ != 0)
            {
               _loc2_ = ComponentFactory.Instance.creatBitmap("asset.CustomizedVipRightItem.addImage");
               _addImageHbox.addChild(_loc2_);
            }
            _loc4_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_sureBtn)
         {
            _sureBtn.addEventListener("click",__sureClickHandler);
         }
         MsgMan.addObserver("REWARD_ITEM_SELECT",this,__onSelectChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_sureBtn)
         {
            _sureBtn.removeEventListener("click",__sureClickHandler);
         }
         MsgMan.removeObserver("REWARD_ITEM_SELECT",this,__onSelectChangeHandler);
      }
      
      private function __sureClickHandler(param1:MouseEvent) : void
      {
         dicCopy(model.frameSelectDic,model.clientBoxDic);
         MsgMan.notifyObserver("BOX_ITEM_SELECT_ALL");
         dispose();
      }
      
      private function __onSelectChangeHandler(param1:String, param2:Object) : void
      {
         var _loc3_:Array = null;
         var _loc4_:Dictionary = null;
         if(!param2 || param2.type == 1)
         {
            return;
         }
         if(param2.type == 2)
         {
            index = param2.index;
            refreshRewardView();
         }
         else if(param2.type == 3)
         {
            _loc3_ = Helpers.getKeyList(data.customizedItemDic);
            _loc4_ = model.frameSelectDic[data.type] ? model.frameSelectDic[data.type] : new SimpleDictionary();
            _loc4_.add(param2.data.area,param2.data);
            model.frameSelectDic.add(data.type,_loc4_);
            itemList[index].boxInfo = param2.boxInfo;
            itemList[index].data = param2.data;
            refreshRewardView();
         }
         refreshBtnState();
      }
      
      public function get data() : CustomizedVipBoxInfo
      {
         return _data;
      }
      
      public function set data(param1:CustomizedVipBoxInfo) : void
      {
         _data = param1;
         if(!data)
         {
            return;
         }
         refreshRewardView();
      }
      
      private function refreshRewardView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:CustomizedVipRewardItem = null;
         _rewardTile.removeAllChild();
         var _loc2_:Array = Helpers.getKeyList(data.customizedItemDic);
         var _loc3_:Array = data.customizedItemDic[_loc2_[index]];
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc1_ = new CustomizedVipRewardItem(3,_loc4_);
            _loc1_.boxInfo = data;
            _loc1_.data = _loc3_[_loc4_];
            _rewardTile.addChild(_loc1_);
            _loc4_++;
         }
         _rewardPanel.commitChanges();
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
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         titleText = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.tipData_customizedvip");
         if(param1 && param1.frameData)
         {
            dicCopy(model.clientBoxDic,model.frameSelectDic);
            data = param1.frameData as CustomizedVipBoxInfo;
            initItemView();
            refreshBtnState();
         }
      }
      
      private function refreshBtnState() : void
      {
         _arrow.x = _itemHbox.x + _itemHbox.getChildAt(index).x + 90 - 12.5;
         if(model.frameSelectDic[data.type] && data.customizedItemDic.keys.length <= model.frameSelectDic[data.type].keys.length)
         {
            _sureBtn.enable = true;
         }
         else
         {
            _sureBtn.enable = false;
         }
      }
      
      private function dicCopy(param1:SimpleDictionary, param2:SimpleDictionary) : void
      {
         var _loc4_:SimpleDictionary = null;
         param2.clear();
         for(var _loc5_:String in param1)
         {
            _loc4_ = new SimpleDictionary();
            for(var _loc3_:String in param1[_loc5_])
            {
               _loc4_.add(_loc3_,param1[_loc5_][_loc3_]);
            }
            param2.add(_loc5_,_loc4_);
         }
      }
      
      private function get model() : CustomizedVipModel
      {
         return CustomizedVipManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         model.frameSelectDic.clear();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_addImageHbox);
         _addImageHbox = null;
         ObjectUtils.disposeObject(_itemHbox);
         _itemHbox = null;
         ObjectUtils.disposeObject(_rewardPanel);
         _rewardPanel = null;
         ObjectUtils.disposeObject(_sureBtn);
         _sureBtn = null;
         ObjectUtils.disposeObject(_rewardTile);
         _rewardTile = null;
         ObjectUtils.disposeObject(_arrow);
         _arrow = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         super.dispose();
      }
   }
}

