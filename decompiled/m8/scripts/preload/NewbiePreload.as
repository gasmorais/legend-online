package preload
{
   import battle.BattleResPreloadManager;
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.ui.ComponentSetting;
   import com.road.pb.helper.army.ThaneInfoHelper;
   import flash.utils.Dictionary;
   import map.campaign.preload.PreLoadFloorData;
   import yishi.manager.ArmyManager;
   import yishi.manager.PathManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.BackUpLoaderStartupUtil;
   
   public class NewbiePreload
   {
      
      private var _prePath:String;
      
      private var _tempArr:Array;
      
      private var _tempStr:String;
      
      public function NewbiePreload()
      {
         super();
         _prePath = DisplayLoader.isDebug ? "" : PathManager.resourcePath;
      }
      
      public function load(param1:Array) : void
      {
         var _loc7_:Array = null;
         var _loc13_:Array = null;
         var _loc9_:Array = null;
         var _loc4_:Array = null;
         var _loc3_:Dictionary = null;
         var _loc11_:String = null;
         var _loc12_:int = 0;
         var _loc5_:String = null;
         for each(var _loc6_:String in param1)
         {
            if(_loc6_ == "")
            {
               continue;
            }
            _tempArr = _loc6_.split(",");
            if(!_tempArr || _tempArr.length <= 0)
            {
               continue;
            }
            switch(int(_tempArr[0]))
            {
               case 0:
                  LoaderManagerII.instance.load(_prePath + _tempArr[1],1,1,null);
                  break;
               case 1:
                  new PreloadDefaultAvatar().load();
                  break;
               case 2:
                  _loc7_ = (_tempArr[1] as String).split("_");
                  _loc13_ = (_tempArr[2] as String).split("_");
                  _loc9_ = BattleResPreloadManager.getPaths(_loc7_,_loc13_,int(_tempArr[3]));
                  for each(var _loc8_:String in _loc9_)
                  {
                     LoaderManagerII.instance.load(_loc8_,1,1,null);
                  }
                  break;
               case 3:
                  _loc4_ = BattleResPreloadManager.loadSelfSkill(false);
                  for each(var _loc2_:String in _loc4_)
                  {
                     LoaderManagerII.instance.load(_loc2_,1,1,null);
                  }
                  break;
               case 4:
                  new PreloadBody023Avatar().load();
                  break;
               case 5:
                  if(DisplayLoader.isDebug)
                  {
                     LoaderManagerII.instance.load(ComponentSetting.NamesLibPath,7,1,null);
                  }
                  else
                  {
                     LoaderManagerII.instance.load(ComponentSetting.NamesLibPath,5,1,null);
                  }
                  break;
               case 6:
                  _loc3_ = new PreLoadFloorData(null).getMapFloorData({
                     "row":int(_tempArr[2]),
                     "column":int(_tempArr[3])
                  },int(_tempArr[1]));
                  for(var _loc10_:String in _loc3_)
                  {
                     LoaderManagerII.instance.load(ComponentSetting.RESOURCE_PATH + _loc10_,1,1,null);
                  }
                  break;
               case 7:
                  _loc11_ = PathManager.resourcePath + "equip/" + ThaneInfoHelper.getSelfJobStr() + _tempArr[1] + ArmyManager.instance.thane.templateInfo.Sexs + ".swf";
                  LoaderManagerII.instance.load(_loc11_,1,1,null);
                  break;
               case 8:
                  _loc12_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.job);
                  _loc5_ = PathManager.getNewbieMovieByJob(_tempArr[1],_loc12_);
                  LoaderManagerII.instance.load(_loc5_,2,1,null);
                  break;
               case 9:
                  BackUpLoaderStartupUtil.addUIModule();
            }
         }
      }
      
      public function dispose() : void
      {
         _prePath = null;
         if(_tempArr)
         {
            _tempArr.length = 0;
         }
         _tempArr = null;
         _tempStr = null;
      }
   }
}

