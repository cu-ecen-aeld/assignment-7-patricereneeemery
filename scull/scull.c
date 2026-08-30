#include <linux/init.h>
#include <linux/module.h>
#include <linux/fs.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("patricereneeemery");
MODULE_DESCRIPTION("Minimal SCULL driver for Azure test harness");

static int scull_major = 0;

static int __init scull_init(void)
{
    scull_major = register_chrdev(0, "scull", NULL);
    if (scull_major < 0) {
        pr_err("scull: failed to register char device\n");
        return scull_major;
    }

    pr_info("scull: registered with major number %d\n", scull_major);
    return 0;
}

static void __exit scull_exit(void)
{
    unregister_chrdev(scull_major, "scull");
    pr_info("scull: unregistered\n");
}

module_init(scull_init);
module_exit(scull_exit);
