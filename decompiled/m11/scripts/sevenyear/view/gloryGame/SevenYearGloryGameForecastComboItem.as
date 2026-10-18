package sevenyear.view.gloryGame
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ComboBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.Glory.PlayerBetMsg;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.GloryGameManager;
   import mvc.module.gloryGame.GloryGameBetInfo;
   import mvc.module.gloryGame.GloryGameModel;
   import mvc.module.gloryGame.GloryGameScheduleInfo;
   import yishi.utils.HashMap;
   import yishi.view.tips.MessageTipManager;
   
   public class SevenYearGloryGameForecastComboItem extends Component
   {
      
      private var combo11:ComboBox;
      
      private var combo12:ComboBox;
      
      private var combo21:ComboBox;
      
      private var combo22:ComboBox;
      
      private var dataGroups1:Array;
      
      private var dataGroups2:Array;
      
      private var _round:int;
      
      private var _index:int;
      
      private var _thisGroup:int;
      
      private var scheduleArr1:HashMap;
      
      private var scheduleArr2:HashMap;
      
      private var _defaultTxt1:FilterFrameText;
      
      private var _defaultTxt2:FilterFrameText;
      
      private var spMask:Sprite;
      
      public function SevenYearGloryGameForecastComboItem(param1:Array, param2:int, param3:int, param4:int)
      {
         super();
         dataGroups1 = param1[0];
         dataGroups2 = param1[1];
         this._round = param2;
         this._index = param4;
         this._thisGroup = param3;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc6_:Array = null;
         var _loc2_:int = 0;
         var _loc7_:* = null;
         var _loc3_:* = null;
         var _loc1_:* = undefined;
         var _loc4_:GloryGameBetInfo = null;
         combo11 = ComponentFactory.Instance.creatComponentByStylename("gloryGame.comBox1");
         addChild(combo11);
         combo11.x += 25;
         combo12 = ComponentFactory.Instance.creatComponentByStylename("gloryGame.comBox2");
         combo21 = ComponentFactory.Instance.creatComponentByStylename("gloryGame.comBox1");
         if(_index != 7)
         {
            addChild(combo21);
         }
         combo21.x += 25;
         combo21.y += 29;
         combo22 = ComponentFactory.Instance.creatComponentByStylename("gloryGame.comBox2");
         combo22.y += 29;
         _defaultTxt1 = ComponentFactory.Instance.creatComponentByStylename("gloryGame.defaultTxt");
         _defaultTxt2 = ComponentFactory.Instance.creatComponentByStylename("gloryGame.defaultTxt");
         addChild(_defaultTxt1);
         addChild(_defaultTxt2);
         _defaultTxt1.x = combo11.x + 5;
         _defaultTxt1.y = combo11.y + 5;
         _defaultTxt2.x = combo21.x + 5;
         _defaultTxt2.y = combo21.y + 5;
         var _loc5_:int = _thisGroup - 1;
         if(_round == 6)
         {
            _defaultTxt1.text = LanguageMgr.GetTranslation("SevenYearGloryGame.rankStr5");
         }
         else if(_round == 3)
         {
            _loc6_ = [["A","B"],["B","C"],["C","D"],["D","A"]];
            _defaultTxt1.text = LanguageMgr.GetTranslation("SevenYearGloryGame.rankStr2",_loc6_[_loc5_][0],1);
            _defaultTxt2.text = LanguageMgr.GetTranslation("SevenYearGloryGame.rankStr2",_loc6_[_loc5_][1],2);
         }
         else if(_round == 4)
         {
            _defaultTxt1.text = LanguageMgr.GetTranslation("SevenYearGloryGame.rankStr3",(_loc5_ + 1) * 2 - 1);
            _defaultTxt2.text = LanguageMgr.GetTranslation("SevenYearGloryGame.rankStr3",(_loc5_ + 1) * 2);
         }
         else if(_round == 5)
         {
            _defaultTxt1.text = LanguageMgr.GetTranslation("SevenYearGloryGame.rankStr4",1);
            _defaultTxt2.text = LanguageMgr.GetTranslation("SevenYearGloryGame.rankStr4",2);
         }
         gray(combo11,false);
         gray(combo12,false);
         gray(combo21,false);
         gray(combo22,false);
         if(cannotModify)
         {
            gray(combo11,true);
            gray(combo21,true);
         }
         _loc1_ = new Vector.<GloryGameScheduleInfo>();
         scheduleArr1 = new HashMap();
         scheduleArr2 = new HashMap();
         for each(_loc2_ in dataGroups1)
         {
            _loc1_ = GloryGameManager.instance.getSchedulesByRoundAndGroup(2,_loc2_);
            for each(_loc7_ in _loc1_)
            {
               if(_loc7_.teamName1)
               {
                  scheduleArr1.put(LanguageMgr.GetTranslation("SevenYearGloryGame.schedule.str1",_loc7_.teamName1),_loc7_.teamUid1);
               }
               if(_loc7_.teamName2)
               {
                  scheduleArr1.put(LanguageMgr.GetTranslation("SevenYearGloryGame.schedule.str1",_loc7_.teamName2),_loc7_.teamUid2);
               }
            }
         }
         for each(_loc3_ in scheduleArr1.keySet)
         {
            if(_loc3_)
            {
               combo11.listPanel.vectorListModel.append(_loc3_);
            }
         }
         for each(_loc2_ in dataGroups2)
         {
            _loc1_ = GloryGameManager.instance.getSchedulesByRoundAndGroup(2,_loc2_);
            for each(_loc7_ in _loc1_)
            {
               if(_loc7_.teamName1)
               {
                  scheduleArr2.put(LanguageMgr.GetTranslation("SevenYearGloryGame.schedule.str1",_loc7_.teamName1),_loc7_.teamUid1);
               }
               if(_loc7_.teamName2)
               {
                  scheduleArr2.put(LanguageMgr.GetTranslation("SevenYearGloryGame.schedule.str1",_loc7_.teamName2),_loc7_.teamUid2);
               }
            }
         }
         for each(_loc3_ in scheduleArr2.keySet)
         {
            if(_loc3_)
            {
               combo21.listPanel.vectorListModel.append(_loc3_);
            }
         }
         if(GloryGameManager.instance.model.myBetInfos)
         {
            _loc4_ = GloryGameManager.instance.model.myBetInfos.getValue(_index + 1) as GloryGameBetInfo;
            if(_loc4_)
            {
               if(_loc4_.teamName1)
               {
                  _defaultTxt1.visible = false;
               }
               if(_loc4_.teamName2)
               {
                  _defaultTxt2.visible = false;
               }
               combo11.listPanel.list.defaultSelectItemByCellValue = LanguageMgr.GetTranslation("SevenYearGloryGame.schedule.str1",_loc4_.teamName1);
               combo21.listPanel.list.defaultSelectItemByCellValue = LanguageMgr.GetTranslation("SevenYearGloryGame.schedule.str1",_loc4_.teamName2);
               combo12.listPanel.list.defaultSelectItemByCellValue = _loc4_.teamScore1;
               combo22.listPanel.list.defaultSelectItemByCellValue = _loc4_.teamScore2;
            }
         }
         spMask = new Sprite();
         spMask.graphics.beginFill(5592405,0);
         spMask.graphics.drawRect(0,0,130,55);
         spMask.graphics.endFill();
         spMask.x = 25;
      }
      
      public function get cannotModify() : Boolean
      {
         return model.currentRound >= _round || model.currentRound == _round - 1 && model.currentState >= 4;
      }
      
      public function get model() : GloryGameModel
      {
         return GloryGameManager.instance.model;
      }
      
      public function get selectedData() : PlayerBetMsg
      {
         var _loc1_:PlayerBetMsg = new PlayerBetMsg();
         _loc1_.round = _round;
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < scheduleArr1.size)
         {
            if(combo11.currentSelectedItem && combo11.currentSelectedItem.text == scheduleArr1.getKeyByIndex(_loc2_))
            {
               _loc1_.teamUid1 = scheduleArr1.getValueByIndex(_loc2_) as String;
            }
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < scheduleArr2.size)
         {
            if(combo21.currentSelectedItem && combo21.currentSelectedItem.text == scheduleArr2.getKeyByIndex(_loc2_))
            {
               _loc1_.teamUid2 = scheduleArr2.getValueByIndex(_loc2_) as String;
            }
            _loc2_++;
         }
         _loc1_.id = _index + 1;
         return _loc1_;
      }
      
      public function set clickable(param1:Boolean) : void
      {
         addChild(spMask);
         if(param1)
         {
            removeChild(spMask);
         }
      }
      
      private function gray(param1:Component, param2:Boolean) : void
      {
         param1.disabled = param2;
         param1.mouseEnabled = !param2;
         param1.mouseChildren = !param2;
      }
      
      private function initEvent() : void
      {
         spMask.addEventListener("click",onClickMask);
         combo11.listPanel.list.addEventListener("listItemClick",onClick1);
         combo21.listPanel.list.addEventListener("listItemClick",onClick2);
      }
      
      private function removeEvent() : void
      {
         if(spMask)
         {
            spMask.removeEventListener("click",onClickMask);
         }
         if(combo11)
         {
            combo11.listPanel.list.removeEventListener("listItemClick",onClick1);
         }
         if(combo21)
         {
            combo21.listPanel.list.removeEventListener("listItemClick",onClick2);
         }
      }
      
      private function onClick1(param1:ListItemEvent) : void
      {
         _defaultTxt1.visible = false;
      }
      
      private function onClick2(param1:ListItemEvent) : void
      {
         _defaultTxt2.visible = false;
      }
      
      private function onClickMask(param1:MouseEvent) : void
      {
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("SevenYearGloryGame.unlock.hint"));
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(combo11);
         combo11 = null;
         ObjectUtils.disposeObject(combo12);
         combo12 = null;
         ObjectUtils.disposeObject(combo21);
         combo21 = null;
         ObjectUtils.disposeObject(combo22);
         combo22 = null;
         ObjectUtils.disposeObject(_defaultTxt1);
         _defaultTxt1 = null;
         ObjectUtils.disposeObject(_defaultTxt2);
         _defaultTxt2 = null;
         ObjectUtils.disposeObject(spMask);
         spMask = null;
         scheduleArr1 = null;
         scheduleArr2 = null;
         super.dispose();
      }
   }
}

