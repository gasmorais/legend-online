package child
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildCollectInfo;
   import mvc.module.children.ChildData;
   import mvc.module.children.ChildModel;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.view.community.BaseIconView;
   
   public class ChildListItemView extends Component implements ISelectable
   {
      
      private var itemContiner:Component;
      
      private var itemBack:Bitmap;
      
      private var childIcon:BaseIconView;
      
      private var nameText:FilterFrameText;
      
      private var growthText:FilterFrameText;
      
      private var hasCountText:FilterFrameText;
      
      private var arrowImage:ScaleFrameImage;
      
      private var masteIcon:Image;
      
      private var slavedIcon:Image;
      
      private var awakeIcon:Image;
      
      private var childVbox:VBox;
      
      private var childList:Vector.<ChildListItemCell>;
      
      private var _isSelected:Boolean;
      
      private var _selectState:Boolean;
      
      private var _data:ChildTempInfo;
      
      private var _collectInfo:ChildCollectInfo;
      
      public function ChildListItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         itemBack = ComponentFactory.Instance.creatBitmap("asset.ChildListItemView.typeBack");
         childIcon = ComponentFactory.Instance.creatCustomObject("ChildListItemView.childIcon");
         nameText = ComponentFactory.Instance.creatComponentByStylename("ChildListItemView.nameText");
         growthText = ComponentFactory.Instance.creatComponentByStylename("ChildListItemView.growthText");
         hasCountText = ComponentFactory.Instance.creatComponentByStylename("ChildListItemView.hasCountText");
         arrowImage = ComponentFactory.Instance.creatComponentByStylename("ChildListItemView.arrowImage");
         masteIcon = ComponentFactory.Instance.creatComponentByStylename("ChildListItemView.masteIcon");
         slavedIcon = ComponentFactory.Instance.creatComponentByStylename("ChildListItemView.slavedIcon");
         childVbox = ComponentFactory.Instance.creatComponentByStylename("ChildListItemView.childVbox");
         itemContiner = ComponentFactory.Instance.creatComponentByStylename("ChildListItemView.itemContiner");
         awakeIcon = ComponentFactory.Instance.creatComponentByStylename("ChildListItemView.awakeIcon");
         itemContiner.addChild(itemBack);
         itemContiner.addChild(childIcon);
         itemContiner.addChild(nameText);
         itemContiner.addChild(growthText);
         itemContiner.addChild(hasCountText);
         itemContiner.addChild(arrowImage);
         arrowImage.setFrame(1);
         itemContiner.addChild(masteIcon);
         masteIcon.visible = false;
         itemContiner.addChild(slavedIcon);
         slavedIcon.visible = false;
         itemContiner.addChild(awakeIcon);
         awakeIcon.visible = false;
         addChild(itemContiner);
         addChild(childVbox);
      }
      
      private function addEvent() : void
      {
         itemContiner.addEventListener("click",__childItemSelectHandler);
         MsgMan.addObserver("ChildEvent.HEAD_CHANGE",this,__updateSelectChildHandler);
      }
      
      private function removeEvent() : void
      {
         if(itemContiner)
         {
            itemContiner.removeEventListener("click",__childItemSelectHandler);
         }
         MsgMan.removeObserver("ChildEvent.HEAD_CHANGE",this,__updateSelectChildHandler);
      }
      
      private function __updateSelectChildHandler(param1:String, param2:Object) : void
      {
         if(!model.selectedChild)
         {
            return;
         }
         if(selected && selectState && data && _collectInfo)
         {
            for each(var _loc3_:ChildListItemCell in childList)
            {
               if(_loc3_.data.childId == model.selectedChild.childId)
               {
                  _loc3_.selected = true;
               }
               else
               {
                  _loc3_.selected = false;
               }
            }
         }
      }
      
      private function __childItemSelectHandler(param1:MouseEvent) : void
      {
         if(_collectInfo && model.getChildTypeList(_data.JobType).length > 0)
         {
            if(selected)
            {
               selectState = !selectState;
               MsgMan.notifyObserver("ChildEvent.CHILD_LISTVIEW_UPDATE");
            }
            if(model.selectItemTemp && data && model.selectItemTemp.JobType != data.JobType)
            {
               model.selectedChild = null;
            }
            model.selectItemTemp = data;
         }
      }
      
      public function get data() : ChildTempInfo
      {
         return _data;
      }
      
      public function set data(param1:ChildTempInfo) : void
      {
         _data = param1;
         masteIcon.visible = false;
         slavedIcon.visible = false;
         awakeIcon.visible = false;
         this.tipData = "";
         if(_data)
         {
            _collectInfo = model.getChildCollecInfoByType(_data.JobType);
            childIcon.icon = PathManager.info.ResourcePath + "icon" + _data.Icon;
            nameText.text = _data.JobName;
            if(_collectInfo && model.getChildTypeList(_data.JobType).length > 0)
            {
               if(model.getInChildCollectByType(_data.JobType,1))
               {
                  masteIcon.visible = true;
               }
               if(model.getInChildCollectByType(_data.JobType,2))
               {
                  slavedIcon.visible = true;
               }
               if(_collectInfo.soulWakes > 0)
               {
                  awakeIcon.visible = true;
                  this.tipData = LanguageMgr.GetTranslation("ChildListView.ChildListView.tipData1",_collectInfo.soulWakes);
               }
               else
               {
                  this.tipData = LanguageMgr.GetTranslation("ChildListView.ChildListView.tipData2");
               }
               this.buttonMode = true;
               this.filters = [];
               growthText.htmlText = LanguageMgr.GetTranslation("ChildHandBookItem.growthText.text",_collectInfo.growth);
               hasCountText.htmlText = LanguageMgr.GetTranslation("ChildHandBookItem.hasCountText.text",model.getChildTypeList(_data.JobType).length);
            }
            else
            {
               this.buttonMode = false;
               this.filters = [UIFilter.getGrayFilter()];
               growthText.text = "";
               hasCountText.text = "";
               this.tipData = LanguageMgr.GetTranslation("ChildListView.ChildListView.tipData3");
            }
         }
      }
      
      private function setChildVbox() : void
      {
         var _loc3_:Array = null;
         var _loc2_:int = 0;
         var _loc4_:ChildData = null;
         var _loc1_:ChildListItemCell = null;
         childVbox.removeAllChild();
         cleanChildList();
         childList = new Vector.<ChildListItemCell>();
         if(selected && selectState && data && _collectInfo)
         {
            _loc3_ = model.getChildTypeList(_collectInfo.childType);
            _loc2_ = 0;
            while(_loc2_ < _loc3_.length)
            {
               _loc4_ = _loc3_[_loc2_];
               _loc1_ = new ChildListItemCell();
               _loc1_.data = _loc4_;
               childVbox.addChild(_loc1_);
               childList.push(_loc1_);
               if(model.selectedChild)
               {
                  if(_loc4_.childId == model.selectedChild.childId)
                  {
                     _loc1_.selected = true;
                  }
                  else
                  {
                     _loc1_.selected = false;
                  }
               }
               else if(model.getInChildCollectByType(data.JobType,1))
               {
                  if(_loc4_.fightUserId == playerInfo.userId)
                  {
                     _loc1_.selected = true;
                     model.selectedChild = _loc4_;
                  }
                  else
                  {
                     _loc1_.selected = false;
                  }
               }
               else if(model.getInChildCollectByType(data.JobType,2))
               {
                  if(_loc4_.fightSlaveUserId == playerInfo.userId)
                  {
                     _loc1_.selected = true;
                     model.selectedChild = _loc4_;
                  }
                  else
                  {
                     _loc1_.selected = false;
                  }
               }
               else if(_loc2_ == 0)
               {
                  _loc1_.selected = true;
                  model.selectedChild = _loc4_;
               }
               else
               {
                  _loc1_.selected = false;
               }
               _loc2_++;
            }
         }
      }
      
      public function get selected() : Boolean
      {
         return _isSelected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _isSelected = param1;
      }
      
      public function get selectState() : Boolean
      {
         return _selectState;
      }
      
      public function set selectState(param1:Boolean) : void
      {
         _selectState = param1;
         if(selected && _selectState)
         {
            arrowImage.setFrame(2);
         }
         else
         {
            arrowImage.setFrame(1);
         }
         setChildVbox();
      }
      
      private function cleanChildList() : void
      {
         if(childList)
         {
            for each(var _loc1_:ChildListItemCell in childList)
            {
               ObjectUtils.disposeObject(_loc1_);
               _loc1_ = null;
            }
            childList.length = 0;
            childList = null;
         }
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      private function get model() : ChildModel
      {
         return ChildManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         cleanChildList();
         ObjectUtils.disposeObject(itemBack);
         itemBack = null;
         ObjectUtils.disposeObject(childIcon);
         childIcon = null;
         ObjectUtils.disposeObject(nameText);
         nameText = null;
         ObjectUtils.disposeObject(growthText);
         growthText = null;
         ObjectUtils.disposeObject(hasCountText);
         hasCountText = null;
         ObjectUtils.disposeObject(arrowImage);
         arrowImage = null;
         ObjectUtils.disposeObject(masteIcon);
         masteIcon = null;
         ObjectUtils.disposeObject(slavedIcon);
         slavedIcon = null;
         ObjectUtils.disposeObject(awakeIcon);
         awakeIcon = null;
         ObjectUtils.disposeObject(itemContiner);
         itemContiner = null;
         ObjectUtils.disposeObject(childVbox);
         childVbox = null;
         super.dispose();
      }
   }
}

