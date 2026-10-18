package battle.skillsys.transform
{
   import battle.skillsys.mode.framedata.ColorTransformFrameData;
   import battle.skillsys.mode.framedata.DisplacementFrameData;
   import battle.skillsys.mode.framedata.EffectFrameData;
   import battle.skillsys.mode.framedata.HideFrameData;
   import battle.skillsys.mode.framedata.MoveFrameData;
   import battle.skillsys.mode.framedata.ShockFrameData;
   import battle.skillsys.mode.framedata.ShootFrameData;
   import battle.skillsys.mode.framedata.SkillFrameData;
   import battle.skillsys.mode.framedata.ZoomFrameData;
   
   public class SkillFrameDataTransform
   {
      
      public function SkillFrameDataTransform()
      {
         super();
      }
      
      public static function transformStringToFrameData(param1:SkillFrameData, param2:String) : void
      {
         var _loc3_:Array = param2.split(",");
         if(param1.ActionType > -1)
         {
            SkillFrameDataTransform["createFrameData" + param1.ActionType](param1,_loc3_);
         }
      }
      
      private static function createFrameData0(param1:SkillFrameData, param2:Array) : void
      {
         param1.moveForwardData = new MoveFrameData();
         param1.moveForwardData.target = param2[0];
         param1.moveForwardData.distance = param2[1];
         param1.moveForwardData.type = param2[2];
         param1.moveForwardData.speed = param2[3];
         param1.moveForwardData.dustRes = param2.length > 4 ? param2[4] : null;
         param1.moveForwardData.dustGap = param2.length > 5 ? param2[5] : 0;
      }
      
      private static function createFrameData1(param1:SkillFrameData, param2:Array) : void
      {
         param1.attackLabel = param2[0];
      }
      
      private static function createFrameData2(param1:SkillFrameData, param2:Array) : void
      {
         param1.effectData = new EffectFrameData();
         param1.effectData.type = param2[0];
         param1.effectData.target = param2[1];
         param1.effectData.posX = param2[2];
         param1.effectData.posY = param2[3];
         param1.effectData.effectRes = param2[4];
         param1.effectData.arrange = param2.length > 5 ? param2[5] : 1;
      }
      
      private static function createFrameData3(param1:SkillFrameData, param2:Array) : void
      {
         param1.effectData = new EffectFrameData();
         param1.effectData.type = param2[0];
         param1.effectData.posX = param2[1];
         param1.effectData.posY = param2[2];
         param1.effectData.effectRes = param2[3];
         param1.effectData.backDistance = param2.length > 4 ? param2[4] : 0;
         param1.effectData.delayBleed = param2.length > 5 ? param2[5] : 0;
      }
      
      private static function createFrameData4(param1:SkillFrameData, param2:Array) : void
      {
         param1.zoomData = new ZoomFrameData();
         param1.zoomData.zoom = param2[0];
         param1.zoomData.zoomType = param2[1];
         param1.zoomData.zoomTime = param2[2];
         param1.zoomData.stopTime = param2[3];
         param1.zoomData.backTime = param2[4];
         param1.zoomData.posX = param2[5];
         param1.zoomData.posY = param2[6];
      }
      
      private static function createFrameData5(param1:SkillFrameData, param2:Array) : void
      {
         createFrameData2(param1,param2);
      }
      
      private static function createFrameData6(param1:SkillFrameData, param2:Array) : void
      {
         param1.bgColorData = new ColorTransformFrameData();
         param1.bgColorData.color = uint(param2[0]);
         param1.bgColorData.tweenTime = param2[1];
         param1.bgColorData.stopTime = param2[2];
         param1.bgColorData.atOnceBool = param2[3] == 0 ? false : true;
         param1.bgColorData.isReduce = param2[4] == 0 ? true : false;
      }
      
      private static function createFrameData7(param1:SkillFrameData, param2:Array) : void
      {
         param1.bgShockData = new ShockFrameData();
         param1.bgShockData.time = param2[0];
         param1.bgShockData.range = param2[1];
      }
      
      private static function createFrameData11(param1:SkillFrameData, param2:Array) : void
      {
         param1.shootData = new ShootFrameData();
         param1.shootData.arrowRes = param2[0];
         param1.shootData.flyType = param2[1];
         param1.shootData.speed = param2[2];
         param1.shootData.dannyRes = param2.length > 3 ? param2[3] : "";
         param1.shootData.rippleRes = param2.length > 4 ? param2[4] : null;
         param1.shootData.rippleGap = param2.length > 5 ? param2[5] : 0;
         param1.shootData.curve = param2.length > 6 ? param2[6] : 0;
      }
      
      private static function createFrameData12(param1:SkillFrameData, param2:Array) : void
      {
         param1.shootData = new ShootFrameData();
         param1.shootData.arrowRes = param2[0];
         param1.shootData.startX = param2[1];
         param1.shootData.startY = param2[2];
         param1.shootData.arrowWidth = param2[3];
         param1.shootData.dannyRes = param2[4];
         param1.shootData.dannyFrame = param2.length > 5 ? param2[5] : 0;
      }
      
      private static function createFrameData21(param1:SkillFrameData, param2:Array) : void
      {
         param1.moveForwardData = new MoveFrameData();
         param1.moveForwardData.target = param2[0];
         param1.moveForwardData.distance = param2[1];
         param1.moveForwardData.dustRes = param2.length > 2 ? param2[2] : null;
      }
      
      private static function createFrameData22(param1:SkillFrameData, param2:Array) : void
      {
         param1.moveBackData = new MoveFrameData();
         param1.moveBackData.dustRes = param2.length > 0 ? param2[0] : null;
      }
      
      private static function createFrameData23(param1:SkillFrameData, param2:Array) : void
      {
         param1.displacementForward = new DisplacementFrameData();
         param1.displacementForward.isForward = true;
         param1.displacementForward.target = param2[0];
         param1.displacementForward.offsetX = param2[1];
         param1.displacementForward.offsetY = param2[2];
         param1.displacementForward.disappearEffect = param2[3];
         param1.displacementForward.persistentFrames = param2[4];
         param1.displacementForward.appearEffect = param2.length > 5 ? param2[5] : "";
      }
      
      private static function createFrameData24(param1:SkillFrameData, param2:Array) : void
      {
         param1.displacementBack = new DisplacementFrameData();
         param1.displacementBack.disappearEffect = param2[0];
         param1.displacementBack.persistentFrames = param2[1];
         param1.displacementBack.appearEffect = param2.length > 2 ? param2[2] : "";
      }
      
      private static function createFrameData25(param1:SkillFrameData, param2:Array) : void
      {
         param1.hideData = new HideFrameData();
         param1.hideData.target = param2[0];
         param1.hideData.disappearEffect = param2[1];
         param1.hideData.persistentFrame = param2[2];
         param1.hideData.appearEffect = param2[3];
      }
      
      private static function createFrameData99(param1:SkillFrameData, param2:Array) : void
      {
      }
      
      private static function createFrameData100(param1:SkillFrameData, param2:Array) : void
      {
         param1.moveBackData = new MoveFrameData();
         param1.moveBackData.type = param2[0];
         param1.moveBackData.speed = param2[1];
         param1.moveBackData.dustRes = param2.length > 2 ? param2[2] : null;
         param1.moveBackData.dustGap = param2.length > 3 ? param2[3] : 0;
      }
   }
}

