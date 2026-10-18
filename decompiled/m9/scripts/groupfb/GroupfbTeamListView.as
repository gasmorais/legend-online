package groupfb
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import manager.LanguageMgr;
   import managers.GroupfbManager;
   import mvc.module.groupfb.GroupfbModel;
   import mvc.module.groupfb.GroupfbPlayerInfo;
   
   public class GroupfbTeamListView extends Component
   {
      
      private var _bg:MutipleImage;
      
      private var _teamName:ScaleFrameImage;
      
      private var _titleTxt:FilterFrameText;
      
      private var _itemList:Vector.<GroupfbTeamItem>;
      
      private var _vBox:VBox;
      
      private var _index:int;
      
      public function GroupfbTeamListView(param1:int)
      {
         _index = param1;
         super();
         initView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamListView.bg");
         _teamName = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamListView.teamName");
         _titleTxt = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamListView.titleTxt");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("GroupfbTeamListView.vBox");
         addChild(_bg);
         addChild(_teamName);
         addChild(_titleTxt);
         addChild(_vBox);
         _titleTxt.text = LanguageMgr.GetTranslation("groupfb.GroupfbTeamListView.title");
         _teamName.setFrame(_index);
         initItem();
      }
      
      private function initItem() : void
      {
         var _loc1_:GroupfbTeamItem = null;
         var _loc2_:int = 0;
         _itemList = new Vector.<GroupfbTeamItem>();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new GroupfbTeamItem();
            _loc1_.team = _index;
            _vBox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function unitView() : void
      {
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_teamName)
         {
            _teamName.dispose();
         }
         _teamName = null;
         if(_titleTxt)
         {
            _titleTxt.dispose();
         }
         _titleTxt = null;
         if(_vBox)
         {
            _vBox.dispose();
         }
         _vBox = null;
         if(_itemList)
         {
            while(_itemList.length > 0)
            {
               _itemList.pop().dispose();
            }
            _itemList = null;
         }
      }
      
      public function refreshView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = undefined;
         if(isDie)
         {
            return;
         }
         if(model.hasGroupTeam)
         {
            _loc2_ = model.selfTeam.getTeamList(_index);
            _loc1_ = 0;
            while(_loc1_ < 4)
            {
               if(_loc2_.length > _loc1_)
               {
                  _itemList[_loc1_].data = _loc2_[_loc1_];
               }
               else
               {
                  _itemList[_loc1_].data = null;
               }
               _loc1_++;
            }
         }
         else
         {
            _loc1_ = 0;
            while(_loc1_ < 4)
            {
               _itemList[_loc1_].data = null;
               _loc1_++;
            }
         }
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      private function get model() : GroupfbModel
      {
         return GroupfbManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unitView();
         super.dispose();
      }
   }
}

