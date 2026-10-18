package monopoly.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ListPanel;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   
   public class MonopolyFriendAssistView extends Sprite implements Disposeable
   {
      
      private var _listPanel:ListPanel;
      
      private var _nameTxt:FilterFrameText;
      
      private var _gradesTxt:FilterFrameText;
      
      private var _fightingCapacityTxt:FilterFrameText;
      
      private var _oprateTxt:FilterFrameText;
      
      private var _thane:ThaneInfo;
      
      public function MonopolyFriendAssistView()
      {
         super();
         _thane = ArmyManager.instance.thane;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistView.NameTxt");
         _gradesTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistView.GradesTxt");
         _fightingCapacityTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistView.FightingCapacityTxt");
         _oprateTxt = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistView.OprateTxt");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("monopoly.MonopolyFriendAssistFrame.PlayerListPanel");
         addChild(_nameTxt);
         addChild(_gradesTxt);
         addChild(_fightingCapacityTxt);
         addChild(_oprateTxt);
         addChild(_listPanel);
         _nameTxt.text = LanguageMgr.GetTranslation("monopoly.view.MonopolyFriendAssistView.Title01");
         _gradesTxt.text = LanguageMgr.GetTranslation("monopoly.view.MonopolyFriendAssistView.Title02");
         _fightingCapacityTxt.text = LanguageMgr.GetTranslation("monopoly.view.MonopolyFriendAssistView.Title03");
         _oprateTxt.text = LanguageMgr.GetTranslation("monopoly.view.MonopolyFriendAssistView.Title04");
         _listPanel.list.updateListView();
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_gradesTxt);
         _gradesTxt = null;
         ObjectUtils.disposeObject(_fightingCapacityTxt);
         _fightingCapacityTxt = null;
         ObjectUtils.disposeObject(_oprateTxt);
         _oprateTxt = null;
         ObjectUtils.disposeObject(_listPanel);
         _listPanel = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function refreshList(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:ThaneInfo = null;
         var _loc3_:int = 0;
         _listPanel.beginChanges();
         _listPanel.vectorListModel.clear();
         if(param1)
         {
            param1.sort(sortFunc);
            _loc2_ = _loc4_ = int(param1.length);
            if(_loc4_ < 6)
            {
               _loc2_ = 6;
            }
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               if(_loc3_ <= _loc4_ - 1)
               {
                  _loc5_ = param1[_loc3_] as ThaneInfo;
                  if(_loc5_ && _loc5_.relation != 2 && _loc5_.userId != _thane.userId)
                  {
                     _listPanel.vectorListModel.append(_loc5_);
                  }
               }
               else
               {
                  _listPanel.vectorListModel.append(null);
               }
               _loc3_++;
            }
         }
         _listPanel.commitChanges();
         _listPanel.list.updateListView();
      }
      
      private function sortFunc(param1:ThaneInfo, param2:ThaneInfo) : int
      {
         if(param1.fightingCapacity > param2.fightingCapacity)
         {
            return -1;
         }
         if(param1.fightingCapacity < param2.fightingCapacity)
         {
            return 1;
         }
         if(param1.grades > param2.grades)
         {
            return -1;
         }
         if(param1.grades < param2.grades)
         {
            return 1;
         }
         if(param1.userId > param2.userId)
         {
            return -1;
         }
         if(param1.userId < param2.userId)
         {
            return 1;
         }
         return 0;
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

