package dialog.utils
{
   import flash.events.EventDispatcher;
   
   public class NewbieModel extends EventDispatcher
   {
      
      public static const TUTORIAL_NODES:Object = {
         "11000":{
            "nid":11300,
            "cls":"nodes.NoviceTutorial_10"
         },
         "11300":{
            "nid":11400,
            "cls":"nodes.NoviceTutorial_20"
         },
         "11400":{
            "nid":11500,
            "cls":"nodes.NoviceTutorial_30"
         },
         "11500":{
            "nid":12500,
            "cls":"nodes.NoviceTutorial_40"
         },
         "12500":{
            "nid":14000,
            "cls":"nodes.NoviceTutorial_50"
         },
         "14000":{
            "nid":19000,
            "cls":"nodes.NoviceTutorial_60"
         },
         "19000":{
            "nid":19500,
            "cls":"nodes.NoviceTutorial_160"
         },
         "19500":{
            "nid":20000,
            "cls":"nodes.NoviceTutorial_170"
         },
         "20000":{
            "nid":21000,
            "cls":"nodes.NoviceTutorial_180"
         },
         "21000":{
            "nid":23000,
            "cls":"nodes.NoviceTutorial_190"
         },
         "23000":{
            "nid":25000,
            "cls":"nodes.NoviceTutorial_200"
         }
      };
      
      public static const VICE_GUILD:Object = {"50500":{
         "nid":50500,
         "cls":"nodes.NoviceTutorial_50500"
      }};
      
      public static const VICE_GUILD_2:Object = {"50501":{
         "nid":50501,
         "cls":"nodes.NoviceTutorial_50501"
      }};
      
      public static const NOVICE_LEVEL_NODES:Object = {
         "12":{
            "nid":26000,
            "cls":"nodes.NoviceNode_10"
         },
         "13":{
            "nid":27200,
            "cls":"nodes.NoviceNode_20"
         },
         "15":{
            "nid":35000,
            "cls":"nodes.NoviceNode_30"
         },
         "16":{
            "nid":36000,
            "cls":"nodes.NoviceNode_40"
         },
         "18":{
            "nid":38000,
            "cls":"nodes.NoviceNode_50"
         },
         "50":{
            "nid":45000,
            "cls":"nodes.NoviceNode_60"
         },
         "70":{
            "nid":50000,
            "cls":"nodes.NoviceNode_70"
         }
      };
      
      public static const NOVICE_TASK_NODES:Object = {"1912":{
         "nid":50000,
         "cls":"nodes.NoviceNode_80"
      }};
      
      public static const preloadXML:XML = <nodes>
				<preload fromId="11300" toId="14000">
				  <resource url="0,11.png"/>
				  <resource url="0,ui/zh_cn/swf/queuebar.swf"/>
				  <resource url="0,ui/zh_cn/swf/tasktracebar.swf"/>
				  <resource url="0,ui/zh_cn/swf/chat.swf"/>
				  <resource url="0,ui/zh_cn/swf/toptoolbar.swf"/>
				  <resource url="0,images/bojinshiyanshi.swf"/>
				  <resource url="0,images/mofalvguan.swf"/>
				  <resource url="0,images/binyin.swf"/>
				  <resource url="0,images/neizhengting.swf"/>
				  <resource url="0,images/chuansong.swf"/>
				  <resource url="0,images/home.swf"/>
				  <resource url="0,images/wuxianta.swf"/>
				  <resource url="0,ui/zh_cn/swf/castle.swf"/>
				  <resource url="0,ui/zh_cn/swf/castlemap1.swf"/>
				  <resource url="0,4.png"/>
				  <resource url="8,flytocastle"/>
				  <resource url="8,leavecampaign"/>
				</preload>
			</nodes>
			
	;
      
      public function NewbieModel()
      {
         super();
      }
   }
}

