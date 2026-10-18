package mvc.module.dreamarena
{
   import mvc.controler.DreamArenaController;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   
   public class DreamArenaModel
   {
      
      public static const DAY_TIME:int = 86400000;
      
      public var rankList:Array;
      
      public var myRank:int;
      
      public var myScore:int;
      
      public var hasTicket:int;
      
      public var isOpen:Boolean;
      
      public var winCount:int;
      
      public var loseCount:int;
      
      private var _selectJob:int;
      
      private var _selectIndex:int;
      
      public var selfInfo:DreamArenaSelectRoleInfo;
      
      public var startTime:Date;
      
      public var stopTime:Date;
      
      public var matchStartHour:int;
      
      public var matchStartMin:int;
      
      public var matchStopHour:int;
      
      public var matchStopMin:int;
      
      public var reportData:Object;
      
      public var clientSelectDic:SimpleDictionary;
      
      public function DreamArenaModel()
      {
         super();
         rankList = [];
         selfInfo = new DreamArenaSelectRoleInfo();
         clientSelectDic = new SimpleDictionary(true);
         var _loc2_:String = ConfigInfoManager.instance.getDreamArenaStartTime();
         var _loc1_:String = ConfigInfoManager.instance.getDreamArenaStopTime();
         startTime = DateFormatter.parse(_loc2_,"YYYY-MM-DD hh:mm:ss");
         stopTime = DateFormatter.parse(_loc1_,"YYYY-MM-DD hh:mm:ss");
         matchStartHour = int(ConfigInfoManager.instance.getDreamArenaFightTime()[0].split(":")[0]);
         matchStartMin = int(ConfigInfoManager.instance.getDreamArenaFightTime()[0].split(":")[1]);
         matchStopHour = int(ConfigInfoManager.instance.getDreamArenaFightTime()[1].split(":")[0]);
         matchStopMin = int(ConfigInfoManager.instance.getDreamArenaFightTime()[1].split(":")[1]);
      }
      
      public function get isShow() : Boolean
      {
         if(!startTime || !stopTime)
         {
            return false;
         }
         if(playerModel.playerInfo.vocationGrades <= 0)
         {
            return false;
         }
         if(playerModel.sysCurtime.time >= startTime.time - 86400000 && playerModel.sysCurtime.time < stopTime.time + 86400000)
         {
            return true;
         }
         return false;
      }
      
      public function get canMatch() : Boolean
      {
         var _loc3_:int = playerModel.sysCurtime.hours * 60 + playerModel.sysCurtime.minutes;
         var _loc1_:int = matchStartHour * 60 + matchStartMin;
         var _loc2_:int = matchStopHour * 60 + matchStopMin;
         if(playerModel.sysCurtime.time >= startTime.time && playerModel.sysCurtime.time <= stopTime.time && _loc3_ >= _loc1_ && _loc3_ < _loc2_)
         {
            return true;
         }
         return false;
      }
      
      public function get selectIndex() : int
      {
         return _selectIndex;
      }
      
      public function set selectIndex(param1:int) : void
      {
         if(_selectIndex == param1)
         {
            return;
         }
         if(selectIndex == 1 && getHeroChange())
         {
            control.showChangeSaveAlert(1,changeViewIndex,param1);
         }
         else if(selectIndex == 2 && getRuneChange())
         {
            control.showChangeSaveAlert(2,changeViewIndex,param1);
         }
         else if(selectIndex == 4 && getArtifactChange())
         {
            control.showChangeSaveAlert(4,changeViewIndex,param1);
         }
         else if(selectIndex == 7 && getMainChildChange())
         {
            control.showChangeSaveAlert(7,changeViewIndex,param1);
         }
         else if(selectIndex == 8 && getSlaveChildChange())
         {
            control.showChangeSaveAlert(8,changeViewIndex,param1);
         }
         else if(selectIndex == 6 && getTitanChange())
         {
            control.showChangeSaveAlert(6,changeViewIndex,param1);
         }
         else
         {
            changeViewIndex(param1);
         }
      }
      
      private function changeViewIndex(param1:int) : void
      {
         _selectIndex = param1;
         if(selectIndex != 1)
         {
            _selectJob = selfInfo.selfSelectJob;
            clientSelectDic.del(22);
            clientSelectDic.del(23);
            clientSelectDic.del(24);
         }
         MsgMan.notifyObserver("LEFT_ITEM_SELECT");
      }
      
      public function get selectJob() : int
      {
         return _selectJob;
      }
      
      public function set selectJob(param1:int) : void
      {
         if(_selectJob == param1)
         {
            return;
         }
         if(getHeroChange())
         {
            control.showChangeSaveAlert(1,changeHeroIndex,param1);
         }
         else
         {
            changeHeroIndex(param1);
         }
      }
      
      private function changeHeroIndex(param1:int) : void
      {
         clientSelectDic.del(22);
         if(param1 != 4)
         {
            clientSelectDic.del(23);
            clientSelectDic.del(24);
         }
         _selectJob = param1;
         MsgMan.notifyObserver("LEFT_ITEM_SELECT");
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function checkAllSelected() : int
      {
         if(getHeroChange())
         {
            return 1;
         }
         if(getRuneChange())
         {
            return 2;
         }
         if(getArtifactChange())
         {
            return 4;
         }
         if(getTitanChange())
         {
            return 6;
         }
         if(getMainChildChange())
         {
            return 7;
         }
         if(getSlaveChildChange())
         {
            return 8;
         }
         return 0;
      }
      
      public function getArtifactChange() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc2_:Array = null;
         if(clientSelectDic[6])
         {
            if(clientSelectDic[6] != selfInfo.artifactId)
            {
               _loc1_ = true;
            }
         }
         if(clientSelectDic[7])
         {
            _loc2_ = clientSelectDic[7] as Array;
            if(!checkAryIsSame(_loc2_,selfInfo.armoryAry))
            {
               _loc3_ = true;
            }
         }
         if(_loc1_ || _loc3_)
         {
            return true;
         }
         return false;
      }
      
      public function getRuneChange() : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc1_:Array = null;
         if(clientSelectDic[9])
         {
            _loc1_ = clientSelectDic[9] as Array;
            if(!checkAryIsSame(_loc1_,selfInfo.runeArys))
            {
               _loc2_ = true;
            }
         }
         if(_loc2_)
         {
            return true;
         }
         return false;
      }
      
      public function getMainChildChange() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         if(clientSelectDic[3])
         {
            if(clientSelectDic[3] != selfInfo.mainChildId)
            {
               _loc1_ = true;
            }
         }
         if(clientSelectDic[32])
         {
            if(clientSelectDic[32] != selfInfo.mainChildPetId)
            {
               _loc2_ = true;
            }
         }
         if(_loc1_ || _loc2_)
         {
            return true;
         }
         return false;
      }
      
      public function getSlaveChildChange() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         if(clientSelectDic[4])
         {
            if(clientSelectDic[4] != selfInfo.slaveChildId)
            {
               _loc1_ = true;
            }
         }
         if(clientSelectDic[42])
         {
            if(clientSelectDic[42] != selfInfo.slaveChildPetId)
            {
               _loc2_ = true;
            }
         }
         if(_loc1_ || _loc2_)
         {
            return true;
         }
         return false;
      }
      
      public function getTitanChange() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:Array = null;
         if(clientSelectDic[21])
         {
            _loc2_ = clientSelectDic[21] as Array;
            if(!checkAryIsSame(_loc2_,selfInfo.titanSkillAry,false))
            {
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      public function getHeroChange() : Boolean
      {
         var _loc1_:Boolean = false;
         if(selectJob != selfInfo.selfSelectJob)
         {
            if(clientSelectDic[22])
            {
               _loc1_ = true;
            }
            else if(selectJob == 4)
            {
               if(clientSelectDic[23])
               {
                  _loc1_ = true;
               }
               else if(clientSelectDic[24])
               {
                  _loc1_ = true;
               }
            }
         }
         else if(clientSelectDic[22])
         {
            if(selectJob == 4)
            {
               if(clientSelectDic[22 + 100 + 1] != selfInfo.dragonSkill || clientSelectDic[22 + 100 + 2] != selfInfo.dragonPassiveSkill)
               {
                  _loc1_ = true;
               }
            }
            else
            {
               _loc1_ = true;
            }
         }
         else if(selectJob == 4)
         {
            if(clientSelectDic[23] && clientSelectDic[23] != selfInfo.skillIndex2)
            {
               _loc1_ = true;
            }
            else if(clientSelectDic[24])
            {
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      private function checkAryIsSame(param1:Array, param2:Array, param3:Boolean = true) : Boolean
      {
         var _loc4_:int = 0;
         if(param1.length != param2.length)
         {
            return false;
         }
         if(param3)
         {
            param1.sort(16);
            param2.sort(16);
         }
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            if(param1[_loc4_] != param2[_loc4_])
            {
               return false;
            }
            _loc4_++;
         }
         return true;
      }
      
      private function get control() : DreamArenaController
      {
         return FrameControllerManager.instance.dreamArenaController;
      }
   }
}

