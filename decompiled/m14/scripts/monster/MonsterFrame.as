package monster
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import monster.view.MonsterAccessoriesView;
   import monster.view.MonsterContractView;
   import monster.view.MonsterHandBookView;
   import monster.view.MonsterListView;
   import monster.view.MonsterPropView;
   import monster.view.MonsterSkillView;
   import monster.view.MonsterTrainView;
   import mvc.module.monster.MonsterModel;
   import yishi.manager.MonsterManager;
   import yishi.utils.MsgMan;
   import yishi.view.base.TabPageUtil;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class MonsterFrame extends Frame implements IManualSize
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _listView:MonsterListView;
      
      private var _lineImage:ScaleBitmapImage;
      
      private var _tabPageUtil:TabPageUtil;
      
      private var _propBtn:SelectedIconButton;
      
      private var _trainBtn:SelectedIconButton;
      
      private var _skillBtn:SelectedIconButton;
      
      private var _handBookBtn:SelectedIconButton;
      
      private var _accessoriesBtn:SelectedIconButton;
      
      private var _contractBtn:SelectedIconButton;
      
      private var _btnHbox:HBox;
      
      private var monsterLen:int;
      
      private var _helpBtn:BaseButton;
      
      public function MonsterFrame()
      {
         super();
         initView();
         initBtnView();
         addEvent();
         refreshTabView();
         MonsterManager.instance.sendMonsterInfoRequest();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,808,560);
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("Monster.MonsterFrame.border");
         _listView = ComponentFactory.Instance.creatCustomObject("Monster.MonsterFrame.listView");
         _btnHbox = ComponentFactory.Instance.creatComponentByStylename("MonsterFrame.btnHbox");
         _propBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterFrame.propBtn");
         _trainBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterFrame.trainBtn");
         _skillBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterFrame.skillBtn");
         _handBookBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterFrame.handBookBtn");
         _accessoriesBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterFrame.accessoriesBtn");
         _contractBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterFrame.contractBtn");
         _lineImage = ComponentFactory.Instance.creatComponentByStylename("MonsterFrame.lineImage");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("MonsterFrame.helpBtn");
         addToContent(_border);
         addToContent(_btnHbox);
         addToContent(_listView);
         addToContent(_lineImage);
         addToContent(_helpBtn);
         _btnHbox.addChild(_propBtn);
         _btnHbox.addChild(_trainBtn);
         _btnHbox.addChild(_skillBtn);
         _btnHbox.addChild(_accessoriesBtn);
         _btnHbox.addChild(_contractBtn);
         _btnHbox.addChild(_handBookBtn);
      }
      
      private function initBtnView() : void
      {
         _tabPageUtil = new TabPageUtil();
         _tabPageUtil.addItemPage(_propBtn,creatPropPage);
         _tabPageUtil.addItemPage(_trainBtn,creatTrainPage);
         _tabPageUtil.addItemPage(_skillBtn,creatSkillPage);
         _tabPageUtil.addItemPage(_accessoriesBtn,creatAccessoriesPage);
         _tabPageUtil.addItemPage(_contractBtn,creatContractPage);
         _tabPageUtil.addItemPage(_handBookBtn,creatHandBookPage);
      }
      
      private function creatPropPage() : MonsterPropView
      {
         var _loc1_:MonsterPropView = ComponentFactory.Instance.creatCustomObject("Monster.MonsterFrame.propView");
         addToContent(_loc1_);
         return _loc1_;
      }
      
      private function creatTrainPage() : MonsterTrainView
      {
         var _loc1_:MonsterTrainView = ComponentFactory.Instance.creatCustomObject("Monster.MonsterFrame.trainView");
         addToContent(_loc1_);
         return _loc1_;
      }
      
      private function creatSkillPage() : MonsterSkillView
      {
         var _loc1_:MonsterSkillView = ComponentFactory.Instance.creatCustomObject("Monster.MonsterFrame.skillView");
         addToContent(_loc1_);
         return _loc1_;
      }
      
      private function creatHandBookPage() : MonsterHandBookView
      {
         var _loc1_:MonsterHandBookView = ComponentFactory.Instance.creatCustomObject("Monster.MonsterFrame.handBookView");
         addToContent(_loc1_);
         return _loc1_;
      }
      
      private function creatAccessoriesPage() : MonsterAccessoriesView
      {
         var _loc1_:MonsterAccessoriesView = ComponentFactory.Instance.creatCustomObject("Monster.MonsterFrame.accessoriesView");
         addToContent(_loc1_);
         return _loc1_;
      }
      
      private function creatContractPage() : MonsterContractView
      {
         var _loc1_:MonsterContractView = ComponentFactory.Instance.creatCustomObject("Monster.MonsterFrame.monsterContractView");
         addToContent(_loc1_);
         return _loc1_;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _tabPageUtil.addEventListener("change",tabChangeHandler);
         _helpBtn.addEventListener("click",__helpBtnHandler);
         MsgMan.addObserver("MONSTER_INFO_CHANGE",this,__updateMonsterListHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_tabPageUtil)
         {
            _tabPageUtil.removeEventListener("change",tabChangeHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnHandler);
         }
         MsgMan.removeObserver("MONSTER_INFO_CHANGE",this,__updateMonsterListHandler);
      }
      
      private function __updateMonsterListHandler(param1:String, param2:Object) : void
      {
         if(monsterLen == 0 && model.monsterDic.getList().length > 0)
         {
            _propBtn.enable = _trainBtn.enable = _skillBtn.enable = _accessoriesBtn.enable = _contractBtn.enable = true;
            _tabPageUtil.selectIndex = 0;
            if(_listView)
            {
               _listView.refreshView(true);
            }
         }
         else if(_listView)
         {
            _listView.refreshView();
         }
         monsterLen = model.monsterDic.getList().length;
      }
      
      private function tabChangeHandler(param1:Event) : void
      {
         _lineImage.visible = _tabPageUtil.selectIndex < 3;
         _listView.visible = _tabPageUtil.selectIndex < 3;
      }
      
      private function __helpBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("monster.MonsterFrame.helpFrame");
         _loc2_.show();
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
      
      private function refreshTabView() : void
      {
         monsterLen = model.monsterDic.getList().length;
         if(model.monsterDic.getList().length > 0)
         {
            _propBtn.enable = _trainBtn.enable = _skillBtn.enable = _accessoriesBtn.enable = _contractBtn.enable = true;
            _tabPageUtil.selectIndex = 0;
         }
         else
         {
            _propBtn.enable = _trainBtn.enable = _skillBtn.enable = _accessoriesBtn.enable = _contractBtn.enable = false;
            _tabPageUtil.selectIndex = 5;
         }
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         titleText = LanguageMgr.GetTranslation("MonsterFrame.title.text");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_listView);
         _listView = null;
         ObjectUtils.disposeObject(_btnHbox);
         _btnHbox = null;
         ObjectUtils.disposeObject(_propBtn);
         _propBtn = null;
         ObjectUtils.disposeObject(_trainBtn);
         _trainBtn = null;
         ObjectUtils.disposeObject(_skillBtn);
         _skillBtn = null;
         ObjectUtils.disposeObject(_contractBtn);
         _contractBtn = null;
         ObjectUtils.disposeObject(_handBookBtn);
         _handBookBtn = null;
         ObjectUtils.disposeObject(_accessoriesBtn);
         _accessoriesBtn = null;
         ObjectUtils.disposeObject(_tabPageUtil);
         _tabPageUtil = null;
         ObjectUtils.disposeObject(_lineImage);
         _lineImage = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         model.selectMonster = null;
         super.dispose();
      }
   }
}

