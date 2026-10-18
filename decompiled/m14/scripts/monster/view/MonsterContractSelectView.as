package monster.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import monster.item.MonsterContractSelectItem;
   import mvc.module.monster.MonsterInfo;
   import mvc.module.monster.MonsterModel;
   import utils.LogicUtils;
   import yishi.manager.MonsterManager;
   import yishi.utils.MsgMan;
   
   public class MonsterContractSelectView extends Component
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vbox:VBox;
      
      private var _alertText:FilterFrameText;
      
      private var selectIndex:int;
      
      private var monsterList:Vector.<MonsterContractSelectItem>;
      
      public function MonsterContractSelectView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("MonsterContractSelectView.bg");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("MonsterContractSelectView.scrollPanel");
         _alertText = ComponentFactory.Instance.creatComponentByStylename("MonsterContractSelectView.alertText");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreHeadSelectView.vbox");
         addChild(_bg);
         addChild(_scrollPanel);
         addChild(_alertText);
         _scrollPanel.setView(_vbox);
         _scrollPanel.invalidateViewport();
         _bg.mouseChildren = _bg.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("CONTRACT_ITEM_SELECT",this,__selectMonsterHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("CONTRACT_ITEM_SELECT",this,__selectMonsterHandler);
      }
      
      private function __selectMonsterHandler(param1:String, param2:Object) : void
      {
         var _loc3_:MonsterInfo = param2 as MonsterInfo;
         if(_loc3_)
         {
            MonsterManager.instance.sendSelectContract(selectIndex,_loc3_.monsterId);
         }
         dispose();
      }
      
      public function show(param1:Array, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:MonsterContractSelectItem = null;
         selectIndex = param2;
         monsterList = new Vector.<MonsterContractSelectItem>();
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = new MonsterContractSelectItem();
            _loc3_.data = param1[_loc4_] ? param1[_loc4_] : null;
            _vbox.addChild(_loc3_);
            monsterList.push(_loc3_);
            _loc4_++;
         }
         _vbox.commitChanges();
         _scrollPanel.invalidateViewport();
         _vbox.beginChanges();
         if(param1.length == 0)
         {
            _alertText.text = LanguageMgr.GetTranslation("MonsterExploreHeadSelectView.alertText.text");
            _scrollPanel.visible = false;
            _bg.height = 33;
            _bg.width = 250;
         }
         else
         {
            _alertText.text = "";
            _scrollPanel.visible = true;
            _bg.height = _scrollPanel.height + 10;
            _bg.width = 250;
         }
         LayerManager.Instance.addToLayer(this,7);
      }
      
      private function get model() : MonsterModel
      {
         return MonsterManager.instance.model;
      }
      
      override public function dispose() : void
      {
         if(isDie)
         {
            return;
         }
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_alertText);
         _alertText = null;
         LogicUtils.disposeDisplayCollection(monsterList);
         monsterList = null;
         super.dispose();
      }
   }
}

