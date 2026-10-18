package monsterexplore.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import manager.LanguageMgr;
   import monsterexplore.item.MonsterExpolreHeadSelectItem;
   import mvc.module.monster.MonsterInfo;
   import mvc.module.monster.MonsterModel;
   import utils.LogicUtils;
   import yishi.manager.MonsterManager;
   import yishi.utils.MsgMan;
   
   public class MonsterExploreHeadSelectView extends Component
   {
      
      private static const COLUMN_NUM:int = 6;
      
      private static const ROW_NUM:int = 3;
      
      private var _bg:ScaleBitmapImage;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _tileList:SimpleTileList;
      
      private var _callBack:Function;
      
      private var _alertText:FilterFrameText;
      
      private var monsterList:Vector.<MonsterExpolreHeadSelectItem>;
      
      public function MonsterExploreHeadSelectView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreHeadSelectView.bg");
         _tileList = ComponentFactory.Instance.creatCustomObject("MonsterExploreHeadSelectView.SimpleTileList",[6]);
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreHeadSelectView.scrollPanel");
         _alertText = ComponentFactory.Instance.creatComponentByStylename("MonsterExploreHeadSelectView.alertText");
         addChild(_bg);
         addChild(_scrollPanel);
         addChild(_alertText);
         _scrollPanel.setView(_tileList);
         _scrollPanel.invalidateViewport();
         _bg.mouseChildren = _bg.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("EXPLORE_HEAD_SELECT",this,__selectMonsterHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("EXPLORE_HEAD_SELECT",this,__selectMonsterHandler);
      }
      
      private function __selectMonsterHandler(param1:String, param2:Object) : void
      {
         var _loc3_:MonsterInfo = param2 as MonsterInfo;
         if(_loc3_ && _callBack != null)
         {
            _callBack(_loc3_);
         }
         dispose();
      }
      
      public function show(param1:Array, param2:Function) : void
      {
         var _loc5_:int = 0;
         var _loc3_:MonsterExpolreHeadSelectItem = null;
         _callBack = param2;
         monsterList = new Vector.<MonsterExpolreHeadSelectItem>();
         var _loc4_:int = 6 * Math.ceil(param1.length / 6);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = new MonsterExpolreHeadSelectItem();
            _loc3_.data = param1[_loc5_] ? param1[_loc5_] : null;
            _tileList.addChild(_loc3_);
            monsterList.push(_loc3_);
            _loc5_++;
         }
         _tileList.commitChanges();
         if(param1.length / 6 >= 4)
         {
            _scrollPanel.height = 210;
         }
         else
         {
            _scrollPanel.height = Math.ceil(param1.length / 6) * 53;
         }
         _scrollPanel.invalidateViewport();
         _tileList.beginChanges();
         if(param1.length == 0)
         {
            _alertText.text = LanguageMgr.GetTranslation("MonsterExploreHeadSelectView.alertText.text");
            _bg.height = 33;
            _bg.width = 250;
         }
         else
         {
            _alertText.text = "";
            _bg.height = _scrollPanel.height + 15;
            _bg.width = 350;
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
         ObjectUtils.disposeObject(_tileList);
         _tileList = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_alertText);
         _alertText = null;
         LogicUtils.disposeDisplayCollection(monsterList);
         monsterList = null;
         _callBack = null;
         super.dispose();
      }
   }
}

