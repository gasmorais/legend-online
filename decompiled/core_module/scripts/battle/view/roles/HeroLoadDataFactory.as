package battle.view.roles
{
   import battle.data.GameLoadNeedData;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.ChildTempInfo;
   import yishi.datas.templates.DragonTalkerFightMountTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MountAvatarPathHelper;
   
   public class HeroLoadDataFactory
   {
      
      public static const PART_HAIR1:String = "hair1";
      
      public static const PART_ARMS:String = "arms";
      
      public static const PART_HAIR2:String = "hair2";
      
      public static const PART_CLOAK1:String = "cloak1";
      
      public static const PART_BODY:String = "body";
      
      public static const PART_HAIR3:String = "hair3";
      
      public static const PART_CLOAK2:String = "cloak2";
      
      public static const PART_HAIR4:String = "hair4";
      
      public static const PART_ARMS_BACK:String = "arms2";
      
      public static const PART_MOUNT:String = "mount";
      
      public static const PART_PET_BODY:String = "pet_body";
      
      public static const PART_PET_FOLLOW:String = "pet_follow";
      
      public static const PART_CHILDREN:String = "children";
      
      public function HeroLoadDataFactory()
      {
         super();
      }
      
      public static function create(param1:ThaneInfo, param2:String, param3:Boolean) : GameLoadNeedData
      {
         var _loc8_:GameLoadNeedData = null;
         var _loc5_:String = null;
         var _loc4_:int = 0;
         var _loc12_:String = null;
         var _loc13_:ChildTempInfo = null;
         var _loc6_:DragonTalkerFightMountTempInfo = null;
         var _loc10_:String = param2;
         var _loc7_:RegExp = /\d/;
         var _loc11_:int = param2.search(_loc7_);
         param3 = param3;
         if(_loc11_ > -1)
         {
            _loc10_ = param2.substring(0,_loc11_);
            _loc4_ = int(param2.substring(_loc11_));
         }
         switch(_loc10_)
         {
            case "children":
               _loc13_ = TempleteManager.instance.childTemplateCate.getTemplateByJobAndGrades(param1.childrenJob,param1.childrenGrade);
               _loc5_ = PathManager.info.ResourcePath + "equip/hychild" + _loc13_.ResPath + "/2.swf";
               break;
            case "pet_follow":
               _loc12_ = param1.petTemplate.PetAvatar + "_follow";
               _loc5_ = PathManager.solveHeroAvatarPath(_loc12_,2);
               break;
            case "pet_body":
               if(param1.petTemplate)
               {
                  _loc5_ = PathManager.solveHeroAvatarPath(param1.petTemplate.PetAvatar,2);
               }
               else
               {
                  _loc5_ = "";
               }
               break;
            case "body":
               if(param3)
               {
                  if(VersionSwitch.DRAGONIC_FASHION)
                  {
                     if(param1.bodyFashionAvata)
                     {
                        _loc5_ = PathManager.solveWingAvatarPath(param1.bodyFashionAvata,4,param1.templateInfo.Sexs);
                     }
                     else if(param1.bodyAvata)
                     {
                        _loc5_ = PathManager.solveHeroAvatarPath(param1.bodyAvata,param1.templateInfo.Sexs);
                     }
                     else
                     {
                        _loc5_ = PathManager.solveRoleDefaultPath(4,"body",param1.templateInfo.Sexs);
                     }
                  }
                  else
                  {
                     _loc5_ = PathManager.solveRoleDefaultPath(4,"body",param1.templateInfo.Sexs);
                  }
               }
               else if(param1.templateId == 100)
               {
                  _loc5_ = PathManager.getDefaultJobBattleAvatar();
               }
               else if(param1.bodyFashionAvata)
               {
                  _loc5_ = PathManager.solveWingAvatarPath(param1.bodyFashionAvata,param1.templateInfo.Job,param1.templateInfo.Sexs);
               }
               else if(param1.bodyAvata)
               {
                  _loc5_ = PathManager.solveHeroAvatarPath(param1.bodyAvata,param1.templateInfo.Sexs);
               }
               else
               {
                  _loc5_ = PathManager.solveRoleDefaultPath(param1.templateInfo.Job,"body",param1.templateInfo.Sexs);
               }
               break;
            case "arms":
               if(param3)
               {
                  if(VersionSwitch.DRAGONIC_FASHION)
                  {
                     if(param1.armsFashionAvata)
                     {
                        _loc5_ = PathManager.solveWingAvatarPath(param1.armsFashionAvata,4,param1.templateInfo.Sexs);
                     }
                     else if(param1.armsAvata)
                     {
                        _loc5_ = PathManager.solveHeroAvatarPath(param1.armsAvata,param1.templateInfo.Sexs);
                     }
                     else
                     {
                        _loc5_ = PathManager.solveRoleDefaultPath(4,"arms",param1.templateInfo.Sexs);
                     }
                  }
                  else
                  {
                     _loc5_ = PathManager.solveRoleDefaultPath(4,"arms",param1.templateInfo.Sexs);
                  }
               }
               else if(param1.armsFashionAvata)
               {
                  _loc5_ = PathManager.solveWingAvatarPath(param1.armsFashionAvata,param1.templateInfo.Job,param1.templateInfo.Sexs);
               }
               else if(param1.armsAvata)
               {
                  _loc5_ = PathManager.solveHeroAvatarPath(param1.armsAvata,param1.templateInfo.Sexs);
               }
               else
               {
                  _loc5_ = PathManager.solveRoleDefaultPath(param1.templateInfo.Job,"arms",param1.templateInfo.Sexs);
               }
               break;
            case "hair":
               if(param3)
               {
                  if(VersionSwitch.DRAGONIC_FASHION)
                  {
                     if(param1.hairFashionAvata)
                     {
                        _loc5_ = PathManager.solveWingAvatarPath(param1.hairFashionAvata,4,param1.templateInfo.Sexs);
                     }
                     else if(param1.hairAvata)
                     {
                        _loc5_ = PathManager.solveHeroAvatarPath(param1.hairAvata,param1.templateInfo.Sexs);
                     }
                     else
                     {
                        _loc5_ = PathManager.solveRoleDefaultPath(4,"hair",param1.templateInfo.Sexs);
                     }
                  }
                  else
                  {
                     _loc5_ = PathManager.solveRoleDefaultPath(4,"hair",param1.templateInfo.Sexs);
                  }
               }
               else if(param1.hairFashionAvata)
               {
                  _loc5_ = PathManager.solveWingAvatarPath(param1.hairFashionAvata,param1.templateInfo.Job,param1.templateInfo.Sexs);
               }
               else if(param1.hairAvata)
               {
                  _loc5_ = PathManager.solveHeroAvatarPath(param1.hairAvata,param1.templateInfo.Sexs);
               }
               else
               {
                  _loc5_ = PathManager.solveRoleDefaultPath(param1.templateInfo.Job,"hair",param1.templateInfo.Sexs);
               }
               break;
            case "cloak":
               if(param3)
               {
                  if(VersionSwitch.DRAGONIC_FASHION)
                  {
                     if(param1.wingAvata)
                     {
                        _loc5_ = PathManager.solveWingAvatarPath(param1.wingAvata,4,param1.templateInfo.Sexs);
                     }
                     else if(param1.bodyAvata)
                     {
                        _loc5_ = PathManager.solveHeroAvatarPath(param1.bodyAvata + "_cloak",param1.templateInfo.Sexs);
                     }
                     else
                     {
                        _loc5_ = PathManager.solveRoleDefaultPath(4,"body",param1.templateInfo.Sexs,"_cloak");
                     }
                  }
                  else
                  {
                     _loc5_ = PathManager.solveRoleDefaultPath(4,"body",param1.templateInfo.Sexs,"_cloak");
                  }
               }
               else if(param1.wingAvata)
               {
                  _loc5_ = PathManager.solveWingAvatarPath(param1.wingAvata,param1.templateInfo.Job,param1.templateInfo.Sexs);
               }
               else if(param1.bodyAvata)
               {
                  _loc5_ = PathManager.solveHeroAvatarPath(param1.bodyAvata + "_cloak",param1.templateInfo.Sexs);
               }
               else
               {
                  _loc5_ = PathManager.solveRoleDefaultPath(param1.templateInfo.Job,"body",param1.templateInfo.Sexs,"_cloak");
               }
               break;
            case "mount":
               if(param3)
               {
                  _loc6_ = TempleteManager.instance.dragonTalkerFightMountTempcate.getTemplateById(param1.dragonTalkerInfo.battleBeastId);
                  _loc5_ = _loc6_ ? MountAvatarPathHelper.getBattlePath(_loc6_.AvatarPath) : "";
               }
               else
               {
                  _loc5_ = "";
               }
         }
         _loc8_ = new GameLoadNeedData(_loc5_,null,_loc4_);
         _loc8_.isSelf = false;
         var _loc9_:int = ArmyManager.instance.thane.userId;
         if(param1.userId == _loc9_)
         {
            _loc8_.isSelf = true;
         }
         return _loc8_;
      }
   }
}

