package yishi.datas.templates
{
   public class ArtifactTemplateInfo
   {
      
      public var TemplateId:int;
      
      public var TemplateName:String;
      
      public var SonType:int;
      
      public var AttackApt:String;
      
      public var DefenceApt:String;
      
      public var MagicAttackApt:String;
      
      public var MagicDefenceApt:String;
      
      public var PenetrateApt:String;
      
      public var ParryApt:String;
      
      public var LiveApt:String;
      
      public var NeedItem:int;
      
      public var Icon:String;
      
      public var Skills:String;
      
      public var IsOpen:int;
      
      public var IsData:int;
      
      public function ArtifactTemplateInfo()
      {
         super();
      }
      
      public function get AttackMin() : int
      {
         return AttackApt.split(",")[0];
      }
      
      public function get AttackMax() : int
      {
         return AttackApt.split(",")[1];
      }
      
      public function get DefenceMin() : int
      {
         return DefenceApt.split(",")[0];
      }
      
      public function get DefenceMax() : int
      {
         return DefenceApt.split(",")[1];
      }
      
      public function get MagicAttackMin() : int
      {
         return MagicAttackApt.split(",")[0];
      }
      
      public function get MagicAttackMax() : int
      {
         return MagicAttackApt.split(",")[1];
      }
      
      public function get MagicDefenceMin() : int
      {
         return MagicDefenceApt.split(",")[0];
      }
      
      public function get MagicDefenceMax() : int
      {
         return MagicDefenceApt.split(",")[1];
      }
      
      public function get PenetrateMin() : int
      {
         return PenetrateApt.split(",")[0];
      }
      
      public function get PenetrateMax() : int
      {
         return PenetrateApt.split(",")[1];
      }
      
      public function get ParryMin() : int
      {
         return ParryApt.split(",")[0];
      }
      
      public function get ParryMax() : int
      {
         return ParryApt.split(",")[1];
      }
      
      public function get LiveMin() : int
      {
         return LiveApt.split(",")[0];
      }
      
      public function get LiveMax() : int
      {
         return LiveApt.split(",")[1];
      }
   }
}

