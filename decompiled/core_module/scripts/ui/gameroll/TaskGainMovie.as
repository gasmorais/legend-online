package ui.gameroll
{
   import com.greensock.TweenLite;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.text.FilterFrameText;
   import manager.LanguageMgr;
   import mvc.module.marry.MarryTask;
   import mvc.module.offerreward.BaseOfferReward;
   import mvc.module.ringtask.RingTask;
   import mvc.module.task.TaskTemplate;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.OfferRewardTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   
   public class TaskGainMovie
   {
      
      private static var _data:Object;
      
      private static var _textList:Vector.<FilterFrameText>;
      
      public static var isGiveUp:Boolean = false;
      
      private static var initY:int;
      
      private static var _rewardList:Array = ["RewardPlayGP","RewardGold","RewardStrategy","RewardCrystal","RewardConsortiaOffer","RewardPlayerOffer"];
      
      public function TaskGainMovie()
      {
         super();
      }
      
      public static function taskMovie(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc5_:int = 0;
         var _loc4_:FilterFrameText = null;
         var _loc3_:int = 0;
         if(isGiveUp)
         {
            isGiveUp = false;
            return;
         }
         if(param1 is TaskTemplate)
         {
            _data = param1 as TaskTemplate;
         }
         else if(param1 is BaseOfferReward)
         {
            _data = (param1 as BaseOfferReward).rewardTemp;
         }
         else if(param1 is RingTask)
         {
            _data = (param1 as RingTask).ringTaskTemp;
         }
         else if(param1 is MarryTask)
         {
            _data = (param1 as MarryTask).marryTaskTemp;
         }
         if(!_data)
         {
            return;
         }
         if(!_textList)
         {
            _textList = new Vector.<FilterFrameText>();
         }
         var _loc6_:int = int(thane.vocationGrades > 0 ? thane.vocationGrades : 0);
         _loc5_ = 0;
         while(_loc5_ < _rewardList.length)
         {
            switch(_loc5_)
            {
               case 0:
                  _loc2_ = LanguageMgr.GetTranslation("task.view.TaskRewardItem.iconTips01");
                  break;
               case 1:
                  _loc2_ = LanguageMgr.GetTranslation("task.view.TaskRewardItem.iconTips02");
                  break;
               case 2:
                  _loc2_ = LanguageMgr.GetTranslation("task.view.TaskRewardItem.iconTips03");
                  break;
               case 3:
                  _loc2_ = LanguageMgr.GetTranslation("task.view.TaskRewardItem.iconTips04");
                  break;
               case 4:
                  _loc2_ = LanguageMgr.GetTranslation("task.view.TaskRewardItem.iconTips05");
                  break;
               case 5:
                  _loc2_ = LanguageMgr.GetTranslation("task.view.TaskRewardItem.iconTips06");
                  break;
               default:
                  _loc2_ = "";
            }
            _loc2_ += " +";
            if(_data.hasOwnProperty(_rewardList[_loc5_]) && int(_data[_rewardList[_loc5_]]) > 0)
            {
               _loc4_ = ComponentFactory.Instance.creatComponentByStylename("task.TaskGainMovie.text");
               _textList.push(_loc4_);
               if(_data is TaskTemplate)
               {
                  if(_data.TemplateType == 1 && _loc5_ == 0)
                  {
                     _loc4_.text = _loc2_ + (int(_data[_rewardList[_loc5_]]) + (thane.grades - _data.NeedMinLevel) * 500).toString();
                  }
                  else
                  {
                     _loc4_.text = _loc2_ + int(_data[_rewardList[_loc5_]]).toString();
                  }
               }
               else if(_data is OfferRewardTemplate)
               {
                  if(param1 is BaseOfferReward)
                  {
                     _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.isChangeJob ? 80 : thane.vocationGrades);
                     if((param1 as BaseOfferReward).profile != 5)
                     {
                        _loc4_.text = _loc2_ + (int(_data[_rewardList[_loc5_]]) * (param1 as BaseOfferReward).profile * (thane.grades + _loc3_)).toString();
                     }
                     else
                     {
                        _loc4_.text = _loc2_ + (int(_data[_rewardList[_loc5_]]) * ((param1 as BaseOfferReward).profile + 1) * (thane.grades + _loc3_)).toString();
                     }
                  }
                  else
                  {
                     _loc4_.text = _loc2_ + int(_data[_rewardList[_loc5_]]).toString();
                  }
               }
               _loc4_.x = (StageReferance.stageWidth - _loc4_.width) / 2 - 7;
               _loc4_.y = initY = StageReferance.stageHeight - 220;
               if(_textList.indexOf(_loc4_) == 0)
               {
                  playRewardText1(_loc4_);
               }
            }
            _loc5_++;
         }
      }
      
      private static function playRewardText1(param1:FilterFrameText) : void
      {
         LayerManager.Instance.addToLayer(param1,0,false,false);
         TweenLite.to(param1,0.75,{
            "y":initY - 22,
            "alpha":0.75,
            "onComplete":__completeHandler1,
            "onCompleteParams":[param1]
         });
      }
      
      private static function __completeHandler1(param1:FilterFrameText) : void
      {
         TweenLite.killTweensOf(param1);
         if(_textList.indexOf(param1) >= 0)
         {
            _textList.splice(_textList.indexOf(param1),1);
         }
         playRewardText2(param1);
         if(_textList.length > 0)
         {
            playRewardText1(_textList[0]);
         }
      }
      
      private static function playRewardText2(param1:FilterFrameText) : void
      {
         TweenLite.to(param1,3,{
            "y":initY - 66,
            "alpha":0,
            "onComplete":__completeHandler2,
            "onCompleteParams":[param1]
         });
      }
      
      private static function __completeHandler2(param1:FilterFrameText) : void
      {
         TweenLite.killTweensOf(param1);
         if(_textList.indexOf(param1) >= 0)
         {
            _textList.splice(_textList.indexOf(param1),1);
         }
         param1.dispose();
      }
      
      private static function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

