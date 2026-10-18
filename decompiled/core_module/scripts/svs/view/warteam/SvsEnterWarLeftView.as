package svs.view.warteam
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import map.campaign.data.SvsModel;
   import map.campaign.data.SvsUserInfo;
   import mvc.controler.SvsController;
   import yishi.manager.FrameControllerManager;
   
   public class SvsEnterWarLeftView extends Sprite implements Disposeable
   {
      
      private var _bg:MutipleImage;
      
      private var _contentBg:Scale9CornerImage;
      
      private var _titleGap:MutipleImage;
      
      private var _nameTitletTxt:FilterFrameText;
      
      private var _gradsTitleTxt:FilterFrameText;
      
      private var _fightPowerTitleTxt:FilterFrameText;
      
      private var _vBox:VBox;
      
      private var _scrolPanel:ScrollPanel;
      
      private var _memberTxt:FilterFrameText;
      
      private var _memberNumTxt:FilterFrameText;
      
      private var _itemList:Vector.<SvsEnterWarLeftItem>;
      
      private var _controller:SvsController;
      
      private var _model:SvsModel;
      
      public var filterName:String;
      
      public function SvsEnterWarLeftView()
      {
         super();
         _controller = FrameControllerManager.instance.svsController;
         _model = _controller.model;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("svs.SvsEnterWarLeftView.Bg");
         _contentBg = ComponentFactory.Instance.creatComponentByStylename("svs.SvsEnterWarLeftView.ContentBg");
         _titleGap = ComponentFactory.Instance.creatComponentByStylename("svs.SvsEnterWarLeftView.TitileGap");
         _nameTitletTxt = ComponentFactory.Instance.creatComponentByStylename("svs.SvsEnterWarLeftView.NameTitleTxt");
         _gradsTitleTxt = ComponentFactory.Instance.creatComponentByStylename("svs.SvsEnterWarLeftView.GradesTitleTxt");
         _fightPowerTitleTxt = ComponentFactory.Instance.creatComponentByStylename("svs.SvsEnterWarLeftView.FightPowerTitleTxt");
         _scrolPanel = ComponentFactory.Instance.creatComponentByStylename("svs.SvsEnterWarLeftView.ScrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("svs.SvsEnterWarLeftView.Vbox");
         _memberTxt = ComponentFactory.Instance.creatComponentByStylename("gvg.EnterWarMemberText01");
         _memberNumTxt = ComponentFactory.Instance.creatComponentByStylename("gvg.EnterWarMemberText02");
         _nameTitletTxt.text = LanguageMgr.GetTranslation("svs.view.warteam.SvsEnterWarFrame.TitleTxt01");
         _gradsTitleTxt.text = LanguageMgr.GetTranslation("svs.view.warteam.SvsEnterWarFrame.TitleTxt02");
         _fightPowerTitleTxt.text = LanguageMgr.GetTranslation("svs.view.warteam.SvsEnterWarFrame.TitleTxt05");
         _memberTxt.text = LanguageMgr.GetTranslation("gvg.view.ready.EnterWarFrame.memberNum");
         _memberNumTxt.text = "201";
         addChild(_bg);
         addChild(_contentBg);
         addChild(_titleGap);
         addChild(_nameTitletTxt);
         addChild(_gradsTitleTxt);
         addChild(_fightPowerTitleTxt);
         addChild(_scrolPanel);
         addChild(_memberTxt);
         addChild(_memberNumTxt);
         _scrolPanel.beginChanges();
         _scrolPanel.setView(_vBox);
         _scrolPanel.invalidateViewport();
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function setListView() : void
      {
         var i:int;
         var list:Array;
         var filterFunction:Function;
         var item:SvsEnterWarLeftItem;
         var info:SvsUserInfo;
         _vBox.beginChanges();
         clearList();
         if(!_itemList)
         {
            _itemList = new Vector.<SvsEnterWarLeftItem>();
         }
         i = 0;
         list = _model.onlineUserList;
         if(filterName)
         {
            filterFunction = function(param1:SvsUserInfo, param2:int, param3:Array):Boolean
            {
               if(param1.nickName.indexOf(filterName) >= 0)
               {
                  return true;
               }
               return false;
            };
            list = list.filter(filterFunction,null);
         }
         for each(info in list)
         {
            item = new SvsEnterWarLeftItem();
            item.data = info;
            item.index = i++;
            _itemList.push(item);
            _vBox.addChild(item);
         }
         _memberNumTxt.text = i + "";
         while(i < 9)
         {
            item = new SvsEnterWarLeftItem();
            item.data = null;
            item.index = i++;
            _itemList.push(item);
            _vBox.addChild(item);
         }
         _vBox.refreshChildPos();
         _vBox.commitChanges();
         _scrolPanel.invalidateViewport();
      }
      
      private function clearList() : void
      {
         for each(var _loc1_:SvsEnterWarLeftItem in _itemList)
         {
            _loc1_.dispose();
         }
         while(_itemList && _itemList.length > 0)
         {
            _itemList.pop();
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

